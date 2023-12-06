import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/data/model/address/user_address_response.dart';
import 'package:onlinebozor/data/model/region%20/region_response.dart';
import 'package:onlinebozor/domain/repository/user_address_response.dart';
import 'package:onlinebozor/domain/repository/user_repository.dart';

import '../../../../../../../../../common/core/base_cubit.dart';

part 'add_address_cubit.freezed.dart';
part 'add_address_state.dart';

@injectable
class AddAddressCubit
    extends BaseCubit<AddAddressBuildable, AddAddressListenable> {
  AddAddressCubit(this._userRepository, this.userAddressRepository)
      : super(AddAddressBuildable()) {
    getRegions();
  }

  final UserRepository _userRepository;
  final UserAddressRepository userAddressRepository;

  void setAddress(UserAddressResponse? address) {
    display.success("set address call");
    if (address != null) {
      display.success("set address call address!=null");
      build((buildable) => buildable.copyWith(
          address: address,
          isMain: address.is_main,
          geo: address.geo,
          regionId: address.region?.id,
          regionName: address.region?.name,
          districtId: address.district?.id,
          districtName: address.district?.name,
          streetId: address.mahalla?.id,
          streetName: address.mahalla?.name,
          addressName: address.name,
          neighborhoodNum: address.street_num,
          homeNumber: address.home_num,
          apartmentNum: address.apartment_num,
          addressId: address.id));
    } else {
      display.success("set address call address==null");
      build((buildable) => buildable.copyWith(addressId: null));
    }
  }

  void setAddressName(String addressName) {
    build((buildable) => buildable.copyWith(addressName: addressName));
  }

  Future<void> getRegions() async {
    final response = await _userRepository.getRegions();
    build((buildable) => buildable.copyWith(
          regions: response,
        ));
  }

  Future<void> getDistrict() async {
    final regionId = buildable.regionId;
    final response = await _userRepository.getDistricts(regionId ?? 14);
    if (buildable.districtId != null) {
      build((buildable) => buildable.copyWith(
          districts: response,
          districtName: response
              .where((element) => element.id == buildable.districtId)
              .first
              .name));
    } else {
      build((buildable) => buildable.copyWith(districts: response));
    }
  }

  Future<void> getStreets() async {
    try {
      final districtId = buildable.districtId;
      final response = await _userRepository.getStreets(districtId ?? 1419);
      if (buildable.streetId != null) {
        build((buildable) => buildable.copyWith(
              streets: response,
              streetName: response
                  .where((element) => element.id == buildable.streetId)
                  .first
                  .name,
            ));
      } else {
        build((buildable) => buildable.copyWith(
              streets: response,
            ));
      }
    } catch (e) {
      display.error("street error ${e}");
      build((buildable) => buildable.copyWith());
    }
  }

  void setRegion(RegionResponse region) {
    build((buildable) => buildable.copyWith(
        regionId: region.id,
        regionName: region.name,
        districtId: null,
        districtName: "Район*",
        streetId: null,
        streetName: "Улица*"));
    getDistrict();
  }

  void setDistrict(RegionResponse district) {
    build((buildable) => buildable.copyWith(
        districtId: district.id,
        districtName: district.name,
        streetId: null,
        streetName: "Улица*"));
    getStreets();
  }

  void setStreet(RegionResponse street) {
    build((buildable) =>
        buildable.copyWith(streetId: street.id, streetName: street.name));
  }

  void setMainCard(bool? isMain) {
    build((buildable) => buildable.copyWith(isMain: isMain));
  }

  void setHomeNum(String value) {
    build((buildable) => buildable.copyWith(homeNumber: value));
  }

  void setApartmentNum(String value) {
    build((buildable) => buildable.copyWith(apartmentNum: value));
  }

  void setNeighborhoodNum(String value) {
    build((buildable) => buildable.copyWith(neighborhoodNum: value));
  }

  Future<void> validationDate() async {
    if (buildable.addressName != null &&
        (buildable.addressName ?? "").length > 3 &&
        buildable.regionId != null &&
        buildable.districtId != null &&
        buildable.streetId != null &&
        buildable.homeNumber != null &&
        (buildable.geo != null ||
            (buildable.latitude != null && buildable.latitude != null))) {
      if (buildable.addressId == null) {
        await addAddress();
      } else {
        await updateAddress();
      }
    } else {
      display.error("Ma'lumotlarni to'liq kiriting");
    }
  }

  Future<void> addAddress() async {
    try {
      await userAddressRepository.addUserAddress(
          name: buildable.addressName!,
          regionId: buildable.regionId!,
          districtId: buildable.districtId!,
          mahallaId: buildable.streetId!,
          homeNum: buildable.homeNumber ?? "",
          apartmentNum: buildable.apartmentNum ?? "",
          streetNum: buildable.streetName ?? "",
          isMain: buildable.isMain ?? false,
          geo: "${buildable.latitude},${buildable.longitude}");
      display.success("mazil qo'shildi");
    } catch (e) {
      display.error(Strings.loadingStateError);
    }
  }

  Future<void> updateAddress() async {
    try {
      await userAddressRepository.updateUserAddress(
          name: buildable.addressName!,
          regionId: buildable.regionId!,
          districtId: buildable.districtId!,
          mahallaId: buildable.streetId!,
          homeNum: buildable.homeNumber ?? "",
          apartmentNum: buildable.apartmentNum ?? "",
          streetNum: buildable.streetName ?? "",
          isMain: buildable.isMain ?? false,
          geo: "${buildable.latitude},${buildable.longitude}",
          id: buildable.addressId ?? -1,
          state: '');
      display.success("mazil qo'shildi");
    } catch (e) {
      display.error(Strings.loadingStateError);
    }
  }

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle the case where the user has denied the permission
        return;
      } else {
        try {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          double lat = position.latitude;
          double long = position.longitude;
          build((buildable) =>
              buildable.copyWith(latitude: lat, longitude: long));
          display.success("location muvaffaqiyatli olindi");
          print("Latitude: $lat and Longitude: $long");
        } catch (e) {
          log.e(e.toString());
          display
              .error("Location olishda xatolik yuz berdi qayta urinib ko'ring");
        }
      }
    } else {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        double lat = position.latitude;
        double long = position.longitude;
        build(
            (buildable) => buildable.copyWith(latitude: lat, longitude: long));
        display.success("location muvaffaqiyatli olindi");
        print("Latitude: $lat and Longitude: $long");
      } catch (e) {
        log.e(e.toString());
        display
            .error("Location olishda xatolik yuz berdi qayta urinib ko'ring");
      }
    }
  }
}

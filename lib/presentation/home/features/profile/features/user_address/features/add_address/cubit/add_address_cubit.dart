import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';

import '../../../../../../../../../common/core/base_cubit.dart';
import '../../../../../../../../../data/repositories/user_address_repository.dart';
import '../../../../../../../../../data/repositories/user_repository.dart';
import '../../../../../../../../../data/responses/address/user_address_response.dart';
import '../../../../../../../../../data/responses/region/region_response.dart';

part 'add_address_cubit.freezed.dart';

part 'add_address_state.dart';

@injectable
class AddAddressCubit
    extends BaseCubit<AddAddressBuildable, AddAddressListenable> {
  AddAddressCubit(this._userRepository, this.userAddressRepository)
      : super(AddAddressBuildable()) {
    getRegions();
  }

  final UserAddressRepository userAddressRepository;
  final UserRepository _userRepository;

  void setAddress(UserAddressResponse? address) {
    if (address != null) {
      updateState((buildable) => buildable.copyWith(
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
      updateState((buildable) => buildable.copyWith(addressId: null));
    }
  }

  void setAddressName(String addressName) {
    updateState((buildable) => buildable.copyWith(addressName: addressName));
  }

  Future<void> getRegions() async {
    try {
      final response = await _userRepository.getRegions();
      updateState((buildable) => buildable.copyWith(regions: response));
    } catch (e) {
      display.error("street error $e");
      updateState((buildable) => buildable.copyWith());
    }
  }

  Future<void> getDistrict() async {
    final regionId = currentState.regionId;
    final response = await _userRepository.getDistricts(regionId ?? 14);
    if (currentState.districtId != null) {
      updateState((buildable) => buildable.copyWith(
          districts: response,
          districtName: response
              .where((element) => element.id == buildable.districtId)
              .first
              .name));
    } else {
      updateState((buildable) => buildable.copyWith(districts: response));
    }
  }

  Future<void> getStreets() async {
    try {
      final districtId = currentState.districtId;
      final response = await _userRepository.getStreets(districtId ?? 1419);
      if (currentState.streetId != null) {
        updateState((buildable) => buildable.copyWith(
              streets: response,
              streetName: response
                  .where((element) => element.id == buildable.streetId)
                  .first
                  .name,
            ));
      } else {
        updateState((buildable) => buildable.copyWith(
              streets: response,
            ));
      }
    } catch (e) {
      display.error("street error $e");
      updateState((buildable) => buildable.copyWith());
    }
  }

  void setRegion(RegionResponse region) {
    updateState((buildable) => buildable.copyWith(
        regionId: region.id,
        regionName: region.name,
        districtId: null,
        districtName: Strings.userAddressDistrict,
        streetId: null,
        streetName: Strings.userAddressStreet));
    getDistrict();
  }

  void setDistrict(RegionResponse district) {
    updateState((buildable) => buildable.copyWith(
        districtId: district.id,
        districtName: district.name,
        streetId: null,
        streetName: Strings.userAddressStreet));
    getStreets();
  }

  void setStreet(RegionResponse street) {
    updateState((buildable) =>
        buildable.copyWith(streetId: street.id, streetName: street.name));
  }

  void setMainCard(bool? isMain) {
    updateState((buildable) => buildable.copyWith(isMain: isMain));
  }

  void setHomeNum(String value) {
    updateState((buildable) => buildable.copyWith(homeNumber: value));
  }

  void setApartmentNum(String value) {
    updateState((buildable) => buildable.copyWith(apartmentNum: value));
  }

  void setNeighborhoodNum(String value) {
    updateState((buildable) => buildable.copyWith(neighborhoodNum: value));
  }

  Future<void> validationDate() async {
    if (currentState.addressName != null &&
        (currentState.addressName ?? "").length > 3 &&
        currentState.regionId != null &&
        currentState.districtId != null &&
        currentState.streetId != null &&
        currentState.homeNumber != null &&
        (currentState.geo != null ||
            (currentState.latitude != null && currentState.latitude != null))) {
      if (currentState.addressId == null) {
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
          name: currentState.addressName!,
          regionId: currentState.regionId!,
          districtId: currentState.districtId!,
          mahallaId: currentState.streetId!,
          homeNum: currentState.homeNumber ?? "",
          apartmentNum: currentState.apartmentNum ?? "",
          streetNum: currentState.streetName ?? "",
          isMain: currentState.isMain ?? false,
          geo: "${currentState.latitude},${currentState.longitude}");
      emitEvent(AddAddressListenable(AddAddressEffect.navigationToHome));
      display.success("mazil qo'shildi");
    } catch (e) {
      display.error(Strings.loadingStateError);
    }
  }

  Future<void> updateAddress() async {
    try {
      await userAddressRepository.updateUserAddress(
          name: currentState.addressName!,
          regionId: currentState.regionId!,
          districtId: currentState.districtId!,
          mahallaId: currentState.streetId!,
          homeNum: currentState.homeNumber ?? "",
          apartmentNum: currentState.apartmentNum ?? "",
          streetNum: currentState.streetName ?? "",
          isMain: currentState.isMain ?? false,
          geo: "${currentState.latitude},${currentState.longitude}",
          id: currentState.addressId ?? -1,
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
          updateState((buildable) =>
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
        updateState(
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

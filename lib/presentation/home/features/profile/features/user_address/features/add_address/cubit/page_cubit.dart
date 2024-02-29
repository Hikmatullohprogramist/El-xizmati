import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';

import '../../../../../../../../../common/core/base_cubit.dart';
import '../../../../../../../../../data/repositories/user_address_repository.dart';
import '../../../../../../../../../data/repositories/user_repository.dart';
import '../../../../../../../../../data/responses/address/user_address_response.dart';
import '../../../../../../../../../data/responses/region/region_response.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@injectable
class AddAddressCubit extends BaseCubit<PageState, PageEvent> {
  AddAddressCubit(this._userRepository, this.userAddressRepository)
      : super(PageState()) {
    getRegions();
  }

  final UserAddressRepository userAddressRepository;
  final UserRepository _userRepository;

  void setInitialParams(UserAddressResponse? address) {
    if (address != null) {
      updateState((state) => state.copyWith(
          isEditing: true,
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
      updateState((state) => state.copyWith(addressId: null));
    }
  }

  void setAddressName(String addressName) {
    updateState((state) => state.copyWith(addressName: addressName));
  }

  Future<void> getRegions() async {
    try {
      final response = await _userRepository.getRegions();
      updateState((state) => state.copyWith(regions: response));
    } catch (e) {
      display.error("street error $e");
      updateState((state) => state.copyWith());
    }
  }

  Future<void> getDistrict() async {
    final regionId = states.regionId;
    final response = await _userRepository.getDistricts(regionId ?? 14);
    if (states.districtId != null) {
      updateState((state) => state.copyWith(
          districts: response,
          districtName: response
              .where((element) => element.id == state.districtId)
              .first
              .name));
    } else {
      updateState((state) => state.copyWith(districts: response));
    }
  }

  Future<void> getStreets() async {
    try {
      final districtId = states.districtId;
      final response = await _userRepository.getStreets(districtId ?? 1419);
      if (states.streetId != null) {
        updateState((state) => state.copyWith(
              streets: response,
              streetName: response
                  .where((element) => element.id == state.streetId)
                  .first
                  .name,
            ));
      } else {
        updateState((state) => state.copyWith(
              streets: response,
            ));
      }
    } catch (e) {
      display.error("street error $e");
      updateState((state) => state.copyWith());
    }
  }

  void setRegion(RegionResponse region) {
    updateState((state) => state.copyWith(
        regionId: region.id,
        regionName: region.name,
        districtId: null,
        districtName: Strings.commonDistrict,
        streetId: null,
        streetName: Strings.commonDistrict));
    getDistrict();
  }

  void setDistrict(RegionResponse district) {
    updateState((state) => state.copyWith(
        districtId: district.id,
        districtName: district.name,
        streetId: null,
        streetName: Strings.commonNeighborhood));
    getStreets();
  }

  void setStreet(RegionResponse street) {
    updateState((state) =>
        state.copyWith(streetId: street.id, streetName: street.name));
  }

  void setMainCard(bool? isMain) {
    updateState((state) => state.copyWith(isMain: isMain));
  }

  void setHomeNumber(String value) {
    updateState((state) => state.copyWith(homeNumber: value));
  }

  void setApartmentNumber(String value) {
    updateState((state) => state.copyWith(apartmentNum: value));
  }

  void setNeighborhoodNum(String value) {
    updateState((state) => state.copyWith(neighborhoodNum: value));
  }

  Future<void> validationDate() async {
    if (states.addressName != null &&
        (states.addressName ?? "").length > 3 &&
        states.regionId != null &&
        states.districtId != null &&
        states.streetId != null &&
        states.homeNumber != null &&
        (states.geo != null ||
            (states.latitude != null && states.latitude != null))) {

      if (states.isEditing) {
        await updateAddress();
      } else {
        await addAddress();
      }
    } else {
      display.error("Ma'lumotlarni to'liq kiriting");
    }
  }

  Future<void> addAddress() async {
    emitEvent(PageEvent(PageEventType.onStartLoading));
    try {
      await userAddressRepository.addUserAddress(
        name: states.addressName!,
        regionId: states.regionId!,
        districtId: states.districtId!,
        mahallaId: states.streetId!,
        homeNum: states.homeNumber ?? "",
        apartmentNum: states.apartmentNum ?? "",
        streetNum: states.streetName ?? "",
        isMain: states.isMain ?? false,
        geo: "${states.latitude},${states.longitude}",
      );

      emitEvent(PageEvent(PageEventType.onFinishLoading));
      emitEvent(PageEvent(PageEventType.backOnSuccess));
    } catch (e) {
      emitEvent(PageEvent(PageEventType.onFinishLoading));
      display.error(Strings.loadingStateError);
    }
  }

  Future<void> updateAddress() async {
    emitEvent(PageEvent(PageEventType.onStartLoading));
    try {
      await userAddressRepository.updateUserAddress(
        name: states.addressName!,
        regionId: states.regionId!,
        districtId: states.districtId!,
        mahallaId: states.streetId!,
        homeNum: states.homeNumber ?? "",
        apartmentNum: states.apartmentNum ?? "",
        streetNum: states.streetName ?? "",
        isMain: states.isMain ?? false,
        geo: "${states.latitude},${states.longitude}",
        id: states.addressId ?? -1,
        state: '',
      );

      emitEvent(PageEvent(PageEventType.onFinishLoading));
      emitEvent(PageEvent(PageEventType.backOnSuccess));
    } catch (e) {
      emitEvent(PageEvent(PageEventType.onFinishLoading));
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
          updateState(
              (state) => state.copyWith(latitude: lat, longitude: long));
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
        updateState((state) => state.copyWith(latitude: lat, longitude: long));
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

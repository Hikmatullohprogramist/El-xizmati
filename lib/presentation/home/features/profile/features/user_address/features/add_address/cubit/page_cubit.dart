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
      updateState(
        (state) => state.copyWith(
          isEditing: true,
          address: address,
          addressId: address.id,
          isMain: address.is_main,
          geo: address.geo,
          regionId: address.region?.id,
          regionName: address.region?.name,
          districtId: address.district?.id,
          districtName: address.district?.name,
          neighborhoodId: address.mahalla?.id,
          neighborhoodName: address.mahalla?.name,
          addressName: address.name,
          streetName: address.street_num,
          homeNumber: address.home_num,
          apartmentNum: address.apartment_num,
        ),
      );
    } else {
      updateState((state) => state.copyWith(addressId: null));
    }
  }

  void setEnteredAddressName(String addressName) {
    updateState((state) => state.copyWith(addressName: addressName));
  }

  void setSelectedRegion(RegionResponse region) {
    updateState(
      (state) => state.copyWith(
        regionId: region.id,
        regionName: region.name,
        districtId: null,
        districtName: Strings.commonDistrict,
        neighborhoodId: null,
        neighborhoodName: Strings.commonNeighborhood,
      ),
    );
    getDistrict();
  }

  void setSelectedDistrict(RegionResponse district) {
    updateState(
      (state) => state.copyWith(
        districtId: district.id,
        districtName: district.name,
        neighborhoodId: null,
        neighborhoodName: Strings.commonNeighborhood,
      ),
    );
    getStreets();
  }

  void setSelectedNeighborhood(RegionResponse street) {
    updateState(
      (state) => state.copyWith(
        neighborhoodId: street.id,
        neighborhoodName: street.name,
      ),
    );
  }

  void setStreetName(String value) {
    updateState((state) => state.copyWith(streetName: value));
  }

  void setHomeNumber(String value) {
    updateState((state) => state.copyWith(homeNumber: value));
  }

  void setApartmentNumber(String value) {
    updateState((state) => state.copyWith(apartmentNum: value));
  }

  void setMainCard(bool? isMain) {
    updateState((state) => state.copyWith(isMain: isMain));
  }

  Future<void> validationDate() async {
    if (states.addressName != null &&
        (states.addressName ?? "").length > 3 &&
        states.regionId != null &&
        states.districtId != null &&
        states.neighborhoodId != null &&
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
    updateState((state) => state.copyWith(isLoading: true));
    try {
      await userAddressRepository.addUserAddress(
        name: states.addressName!,
        regionId: states.regionId!,
        districtId: states.districtId!,
        neighborhoodId: states.neighborhoodId!,
        homeNum: states.homeNumber ?? "",
        apartmentNum: states.apartmentNum ?? "",
        streetName: states.streetName ?? "",
        isMain: states.isMain ?? false,
        geo: "${states.latitude},${states.longitude}",
      );

      updateState((state) => state.copyWith(isLoading: false));
      emitEvent(PageEvent(PageEventType.backOnSuccess));
    } catch (e) {
      updateState((state) => state.copyWith(isLoading: false));
      display.error(Strings.loadingStateError);
    }
  }

  Future<void> updateAddress() async {
    updateState((state) => state.copyWith(isLoading: true));
    try {
      await userAddressRepository.updateUserAddress(
        name: states.addressName!,
        regionId: states.regionId!,
        districtId: states.districtId!,
        neighborhoodId: states.neighborhoodId!,
        homeNum: states.homeNumber ?? "",
        apartmentNum: states.apartmentNum ?? "",
        streetName: states.streetName ?? "",
        isMain: states.isMain ?? false,
        geo: "${states.latitude},${states.longitude}",
        id: states.addressId ?? -1,
        state: '',
      );

      updateState((state) => state.copyWith(isLoading: false));
      emitEvent(PageEvent(PageEventType.backOnSuccess));
    } catch (e) {
      updateState((state) => state.copyWith(isLoading: false));
      display.error(Strings.loadingStateError);
    }
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
      if (states.neighborhoodId != null) {
        updateState(
          (state) => state.copyWith(
            neighborhoods: response,
            neighborhoodName:
                response.where((e) => e.id == state.neighborhoodId).first.name,
          ),
        );
      } else {
        updateState((state) => state.copyWith(neighborhoods: response));
      }
    } catch (e) {
      display.error("street error $e");
      updateState((state) => state.copyWith());
    }
  }

  Future<void> getCurrentLocation() async {
    updateState((state) => state.copyWith(isLocationLoading: true));
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle the case where the user has denied the permission
        updateState((state) => state.copyWith(isLocationLoading: false));
        return;
      } else {
        try {
          Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high);
          double lat = position.latitude;
          double long = position.longitude;

          updateState(
            (state) => state.copyWith(
              latitude: lat,
              longitude: long,
              isLocationLoading: false,
            ),
          );
          print("Latitude: $lat and Longitude: $long");
        } catch (e) {
          log.e(e.toString());
          updateState((state) => state.copyWith(isLocationLoading: false));
        }
      }
    } else {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        double lat = position.latitude;
        double long = position.longitude;
        updateState(
              (state) => state.copyWith(
            latitude: lat,
            longitude: long,
            isLocationLoading: false,
          ),
        );
        print("Latitude: $lat and Longitude: $long");
      } catch (e) {
        log.e(e.toString());
        updateState((state) => state.copyWith(isLocationLoading: false));
      }
    }
  }
}

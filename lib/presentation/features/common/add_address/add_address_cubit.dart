import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/extensions/list_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/repositories/user_address_repository.dart';
import 'package:onlinebozor/data/repositories/user_repository.dart';
import 'package:onlinebozor/domain/models/district/district.dart';
import 'package:onlinebozor/domain/models/region/region.dart';
import 'package:onlinebozor/domain/models/street/street.dart';
import 'package:onlinebozor/domain/models/user/user_address.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/presentation/support/extensions/extension_message_exts.dart';

part 'add_address_cubit.freezed.dart';
part 'add_address_state.dart';

@injectable
class AddAddressCubit extends BaseCubit<AddAddressState, AddAddressEvent> {
  AddAddressCubit(
    this._userRepository,
    this._userAddressRepository,
  ) : super(AddAddressState()) {
    getRegions();
  }

  final UserAddressRepository _userAddressRepository;
  final UserRepository _userRepository;

  void setInitialParams(UserAddress? address) {
    if (address != null) {
      updateState(
        (state) => state.copyWith(
          isEditing: true,
          address: address,
          addressId: address.id,
          isMain: address.isMain,
          geo: address.geo,
          regionId: address.regionId,
          regionName: address.regionName,
          districtId: address.districtId,
          districtName: address.districtName,
          neighborhoodId: address.neighborhoodId,
          neighborhoodName: address.neighborhoodName,
          addressName: address.name,
          streetName: address.streetName,
          houseNumber: address.houseNumber,
          apartmentNum: address.apartmentNumber,
        ),
      );

      if (states.districtId != null) {
        getDistricts();
      }
      if (states.neighborhoodId != null) {
        getNeighborhoods();
      }
    } else {
      updateState((state) => state.copyWith(addressId: null));
    }
  }

  void setEnteredAddressName(String addressName) {
    updateState((state) => state.copyWith(addressName: addressName));
  }

  void setSelectedRegion(Region region) {
    updateState((state) => state.copyWith(
          regionId: region.id,
          regionName: region.name,
          districtId: null,
          districtName: null,
          neighborhoodId: null,
          neighborhoodName: null,
        ));

    getDistricts();
  }

  void setSelectedDistrict(District district) {
    updateState((state) => state.copyWith(
          districtId: district.id,
          districtName: district.name,
          neighborhoodId: null,
          neighborhoodName: null,
        ));

    getNeighborhoods();
  }

  void setSelectedNeighborhood(Neighborhood neighborhood) {
    updateState((state) => state.copyWith(
          neighborhoodId: neighborhood.id,
          neighborhoodName: neighborhood.name,
        ));
  }

  void setStreetName(String value) {
    updateState((state) => state.copyWith(streetName: value));
  }

  void setHouseNumber(String value) {
    updateState((state) => state.copyWith(houseNumber: value));
  }

  void setApartmentNumber(String value) {
    updateState((state) => state.copyWith(apartmentNum: value));
  }

  void setMainCard(bool? isMain) {
    updateState((state) => state.copyWith(isMain: isMain));
  }

  Future<void> addOrUpdateAddress() async {
    if (states.isEditing) {
      updateAddress();
    } else {
      addAddress();
    }
  }

  void addAddress() {
    _userAddressRepository
        .addUserAddress(
          name: states.addressName!,
          regionId: states.regionId!,
          districtId: states.districtId!,
          neighborhoodId: states.neighborhoodId!,
          homeNum: states.houseNumber?.trim() ?? "",
          apartmentNum: states.apartmentNum?.trim() ?? "",
          streetName: states.streetName?.trim() ?? "",
          isMain: states.isMain ?? false,
          geo: "${states.latitude},${states.longitude}",
        )
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(isLoading: true));
        })
        .onSuccess((data) {
          updateState((state) => state.copyWith(isLoading: false));
          emitEvent(AddAddressEvent(AddAddressEventType.backOnSuccess));
        })
        .onError((error) {
          updateState((state) => state.copyWith(isLoading: false));
          stateMessageManager.showErrorSnackBar(Strings.commonEmptyMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }

  void updateAddress() {
    _userAddressRepository
        .updateUserAddress(
          id: states.addressId!,
          name: states.addressName!,
          regionId: states.regionId!,
          districtId: states.districtId!,
          neighborhoodId: states.neighborhoodId!,
          houseNumber: states.houseNumber?.trim() ?? "",
          apartmentNum: states.apartmentNum?.trim() ?? "",
          streetName: states.streetName?.trim() ?? "",
          isMain: states.isMain ?? false,
          geo: "${states.latitude},${states.longitude}",
          state: '',
        )
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(isLoading: true));
        })
        .onSuccess((data) {
          updateState((state) => state.copyWith(isLoading: false));
          emitEvent(AddAddressEvent(AddAddressEventType.backOnSuccess));
        })
        .onError((error) {
          updateState((state) => state.copyWith(isLoading: false));
          stateMessageManager.showErrorSnackBar(Strings.commonEmptyMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> getRegions() async {
    _userRepository
        .getRegions()
        .initFuture()
        .onSuccess((data) {
          updateState((state) => state.copyWith(regions: data));
        })
        .onError((error) {
          stateMessageManager.showErrorSnackBar(error.localizedMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> getDistricts() async {
    if (states.regionId == null) {
      stateMessageManager
          .showErrorBottomSheet(Strings.commonErrorRegionNotSelected);
      return;
    }

    _userRepository
        .getDistricts(states.regionId!)
        .initFuture()
        .onSuccess((data) {
          updateState((state) => state.copyWith(
                districts: data,
                districtName:
                    data.firstIf((e) => e.id == states.districtId)?.name,
              ));
        })
        .onError((error) {
          stateMessageManager.showErrorSnackBar(error.localizedMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> getNeighborhoods() async {
    if (states.districtId == null) {
      stateMessageManager
          .showErrorBottomSheet(Strings.commonErrorDistrictNotSelected);
      return;
    }

    _userRepository
        .getNeighborhoods(states.districtId!)
        .initFuture()
        .onStart(() {})
        .onSuccess((data) {
          updateState((state) => state.copyWith(
                neighborhoods: data,
                neighborhoodName:
                    data.firstIf((e) => e.id == states.neighborhoodId)?.name,
              ));
        })
        .onError((error) {
          stateMessageManager.showErrorSnackBar(error.localizedMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }

  String getFormattedLocation() {
    return states.latitude == null || states.longitude == null
        ? ""
        : "${states.latitude}, ${states.longitude}";
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
          logger.e(e.toString());
          updateState((state) => state.copyWith(isLocationLoading: false));
        }
      }
    } else {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        double lat = position.latitude;
        double long = position.longitude;
        updateState((state) => state.copyWith(
              latitude: lat,
              longitude: long,
              isLocationLoading: false,
            ));
        print("Latitude: $lat and Longitude: $long");
      } catch (e) {
        logger.e(e.toString());
        updateState((state) => state.copyWith(isLocationLoading: false));
      }
    }
  }
}

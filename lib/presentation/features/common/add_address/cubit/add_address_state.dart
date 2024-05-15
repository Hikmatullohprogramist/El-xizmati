part of 'add_address_cubit.dart';

@freezed
class AddAddressState with _$AddAddressState {
  const factory AddAddressState({
    @Default(false) bool isEditing,
    int? addressId,
    UserAddress? address,
    @Default([]) List<Region> regions,
    @Default([]) List<District> districts,
    @Default([]) List<Neighborhood> neighborhoods,
    String? addressName,
    int? regionId,
    String? regionName,
    int? districtId,
    String? districtName,
    int? neighborhoodId,
    String? neighborhoodName,
    String? streetName,
    String? homeNumber,
    String? apartmentNum,
    bool? isMain,
    double? latitude,
    double? longitude,
    String? geo,
    String? state,
    @Default(false) bool isLoading,
    @Default(false) bool isLocationLoading,
  }) = _AddAddressState;
}

@freezed
class AddAddressEvent with _$AddAddressEvent {
  const factory AddAddressEvent(AddAddressEventType type) = _AddAddressEvent;
}

enum AddAddressEventType {
  // onStartLoading,
  // onFinishLoading,
  backOnSuccess,
}

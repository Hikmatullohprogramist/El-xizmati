part of 'add_address_cubit.dart';

@freezed
class AddAddressBuildable with _$AddAddressBuildable {
  const factory AddAddressBuildable(
      {String? addressName,
      int? regionId,
      String? regionName,
      int? districtId,
      UserAddressResponse? address,
      String? districtName,
      int? streetId,
      String? streetName,
      @Default(<RegionResponse>[]) List<RegionResponse> regions,
      @Default(<RegionResponse>[]) List<RegionResponse> districts,
      @Default(<RegionResponse>[]) List<RegionResponse> streets,
      int? homeNumber,
      String? flat}) = _AddAddressBuildable;
}

@freezed
class AddAddressListenable with _$AddAddressListenable {
  const factory AddAddressListenable(AddAddressEffect effect,
      {String? message}) = _AddAddressListenable;
}

enum AddAddressEffect { success }

part of 'add_address_cubit.dart';

@freezed
class AddAddressBuildable with _$AddAddressBuildable {
  const factory AddAddressBuildable({
    String? addressName,
    int? regionId,
    String? regionName,
    int? districtId,
    String? districtName,
    int? streetId,
    String? streetName,
    String? homeNumber,
    String? apartmentNum,
    String? neighborhoodNum,
    UserAddressResponse? address,
    @Default(<RegionResponse>[]) List<RegionResponse> regions,
    @Default(<RegionResponse>[]) List<RegionResponse> districts,
    @Default(<RegionResponse>[]) List<RegionResponse> streets,
    bool? isMain,
    double? latitude,
    double? longitude,
    String? geo,
    String? flat,
    String? state,
    int? addressId,
  }) = _AddAddressBuildable;
}

@freezed
class AddAddressListenable with _$AddAddressListenable {
  const factory AddAddressListenable(AddAddressEffect effect,
      {String? message}) = _AddAddressListenable;
}

enum AddAddressEffect { navigationToHome }

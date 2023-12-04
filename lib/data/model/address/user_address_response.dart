import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_address_response.freezed.dart';

part 'user_address_response.g.dart';

@freezed
class UserAddressRootResponse with _$UserAddressRootResponse {
  const factory UserAddressRootResponse({
    dynamic error,
    dynamic message,
    String? timestamp,
    int? status,
    dynamic path,
    List<UserAddressResponse>? data,
    dynamic response,
  }) = _UserAddressRootResponse;

  factory UserAddressRootResponse.fromJson(Map<String, dynamic> json) =>
      _$UserAddressRootResponseFromJson(json);
}

@freezed
class UserAddressResponse with _$UserAddressResponse {
  const factory UserAddressResponse({
    int? id,
    District? region,
    District? district,
    int? state,
    String? name,
    District? mahalla,
    String? streetNum,
    String? homeNum,
    String? apartmentNum,
    String? geo,
    bool? isMain,
  }) = _UserAddressResponse;

  factory UserAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$UserAddressResponseFromJson(json);
}

@freezed
class District with _$District {
  const factory District({
    int? id,
    String? name,
  }) = _District;

  factory District.fromJson(Map<String, dynamic> json) =>
      _$DistrictFromJson(json);
}

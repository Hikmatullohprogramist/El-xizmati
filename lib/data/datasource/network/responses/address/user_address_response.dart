import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_address_response.freezed.dart';
part 'user_address_response.g.dart';

@freezed
class UserAddressRootResponse with _$UserAddressRootResponse {
  const factory UserAddressRootResponse({
    dynamic error,
    dynamic message,
    dynamic timestamp,
    int? status,
    dynamic path,
    required List<UserAddressResponse> data,
    dynamic response,
  }) = _UserAddressRootResponse;

  factory UserAddressRootResponse.fromJson(Map<String, dynamic> json) =>
      _$UserAddressRootResponseFromJson(json);
}

@freezed
class UserAddressResponse with _$UserAddressResponse {
  const factory UserAddressResponse({
    required int id,
    UserAddressItemResponse? region,
    UserAddressItemResponse? district,
    UserAddressItemResponse? neighborhood,
    int? state,
    String? name,
    String? street_num,
    String? home_num,
    String? apartment_num,
    String? geo,
    bool? is_main,
  }) = _UserAddressResponse;

  const UserAddressResponse._();

  factory UserAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$UserAddressResponseFromJson(json);
}

@freezed
class UserAddressItemResponse with _$UserAddressItemResponse {
  const factory UserAddressItemResponse({
    int? id,
    String? name,
  }) = _District;

  factory UserAddressItemResponse.fromJson(Map<String, dynamic> json) =>
      _$UserAddressItemResponseFromJson(json);
}

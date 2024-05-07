import 'package:freezed_annotation/freezed_annotation.dart';

part 'ad_address_response.freezed.dart';
part 'ad_address_response.g.dart';

@freezed
class AdAddressResponse with _$AdAddressResponse {
  const factory AdAddressResponse({
    required int id,
    required String? name,
  }) = _AdAddressResponse;

  factory AdAddressResponse.fromJson(Map<String, dynamic> json) =>
      _$AdAddressResponseFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'active_device_response.freezed.dart';

part 'active_device_response.g.dart';

@freezed
class ActiveDeviceRootResponse with _$ActiveDeviceRootResponse {
  const factory ActiveDeviceRootResponse({
    dynamic error,
    dynamic message,
    String? timestamp,
    int? status,
    dynamic path,
    required List<ActiveDeviceResponse> data,
    dynamic response,
  }) = _ActiveDeviceRootResponse;

  factory ActiveDeviceRootResponse.fromJson(Map<String, dynamic> json) =>
      _$ActiveDeviceRootResponseFromJson(json);
}

@freezed
class ActiveDeviceResponse with _$ActiveDeviceResponse {
  const factory ActiveDeviceResponse({
    required int id,
    required String token,
    String? last_activity_at,
    String? last_login_at,
    required String user_agent,
    int? user_id,
    String? last_ip_address,
  }) = _ActiveDeviceResponse;

  factory ActiveDeviceResponse.fromJson(Map<String, dynamic> json) =>
      _$ActiveDeviceResponseFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_send_sms_response.freezed.dart';
part 'auth_send_sms_response.g.dart';

@freezed
class AuthSendSMSResponse with _$AuthSendSMSResponse {
  const factory AuthSendSMSResponse({
    dynamic data,
    dynamic error,
  }) = _AuthSendSMSResponse;

  factory AuthSendSMSResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthSendSMSResponseFromJson(json);
}



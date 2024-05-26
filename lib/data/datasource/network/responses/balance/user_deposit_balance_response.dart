import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_deposit_balance_response.freezed.dart';
part 'user_deposit_balance_response.g.dart';

@freezed
class UserDepositBalanceRootResponse with _$UserDepositBalanceRootResponse {
  const factory UserDepositBalanceRootResponse({
    dynamic error,
    dynamic message,
    String? timestamp,
    int? status,
    dynamic path,
    required UserDepositBalance data,
    dynamic response,
  }) = _UserDepositBalanceRootResponse;

  factory UserDepositBalanceRootResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDepositBalanceRootResponseFromJson(json);
}

@freezed
class UserDepositBalance with _$UserDepositBalance {
  const factory UserDepositBalance({
    @JsonKey(name: "amount") double? amount,
    @JsonKey(name: "time_calculated") String? calculatedAt,
    @JsonKey(name: "user_type") String? userType,
    @JsonKey(name: "hold_sum") double? holdAmount,
  }) = _UserDepositBalance;

  factory UserDepositBalance.fromJson(Map<String, dynamic> json) =>
      _$UserDepositBalanceFromJson(json);
}

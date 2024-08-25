part of'change_password_cubit.dart';
@freezed
class ChangePasswordState with _$ChangePasswordState{
  const ChangePasswordState._();

  const factory ChangePasswordState({
    @Default("") String currentPassword,
    @Default("") String newPassword,
    @Default("") String confirmPassword,
}) = _ChangePasswordState;

}
@freezed
class ChangePasswordEvent with _$ChangePasswordEvent{
  const factory ChangePasswordEvent() = _ChangePasswordEvent;
}
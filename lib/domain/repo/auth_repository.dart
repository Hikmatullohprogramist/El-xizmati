import '../model/auth/auth_start/auth_start_response.dart';

abstract class AuthRepository {
  Future<AuthStartResponse> authStart(String phone);

  Future<void> confirm(String phone, String code);

  Future<void> verification(String phone, String password);

  Future<void> forgetPassword(String phone);

  Future<void> registerOrResetPassword(String password, String repeatPassword);

  Future<void> recoveryConfirm(String phone, String code);

  Future<void> loginWithOneId(String accessCode);
}

import '../model/auth/auth_start/auth_start_response.dart';
import '../model/auth/confirm/confirm_response.dart';
import '../model/auth/forget_password/forget_password_response.dart';
import '../model/auth/login /login_response.dart';
import '../model/auth/register/register_response.dart';

abstract class AuthRepository {
  Future<AuthStartResponse> authStart(String phone);

  Future<LoginResponse> verification(String phone, String password);

  Future<ForgetPasswordResponse?> forgetPassword(String phone);

  Future<RegisterResponse> register(String phone, String code);

  Future<ConfirmResponse> setPassword(String password, String repeatPassword);

  Future<void> verify(String phone, String code);

  Future<bool> isLogin();
}

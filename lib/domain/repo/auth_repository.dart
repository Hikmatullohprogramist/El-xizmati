import 'package:onlinebozor/domain/model/confirm/confirm_response.dart';
import 'package:onlinebozor/domain/model/forget_password/forget_password_response.dart';
import 'package:onlinebozor/domain/model/login%20/login_response.dart';
import 'package:onlinebozor/domain/model/register/register_response.dart';

import '../model/auth/auth_start/auth_start_response.dart';

abstract class AuthRepository {
  Future<AuthStartResponse> authStart(String phone);

  Future<LoginResponse> verification(String phone, String password);

  Future<ForgetPasswordResponse?> forgetPassword(String phone);

  Future<RegisterResponse> register(String phone, String code);

  Future<ConfirmResponse> setPassword(String password, String repeatPassword);

  Future<void> verify(String phone, String code);

  Future<bool> isLogin();
}

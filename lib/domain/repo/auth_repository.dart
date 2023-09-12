abstract class AuthRepository {
  Future<void> login(String phone);
  Future<void> verify(String phone, String code);
}
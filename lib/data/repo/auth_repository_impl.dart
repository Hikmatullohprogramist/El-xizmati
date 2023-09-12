import 'package:onlinebozor/data/api/auth_api.dart';
import 'package:onlinebozor/data/storage/storage.dart';
import 'package:onlinebozor/domain/model/token/token.dart';
import 'package:onlinebozor/domain/repo/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl extends AuthRepository {
  final AuthApi _api;
  final Storage _storage;

  AuthRepositoryImpl(this._api, this._storage);

  @override
  Future<void> login(String phone) {
    return _api.login(phone);
  }

  @override
  Future<void> verify(String phone, String code) async {
    final response = await _api.verify(phone, code);
    final token = Token.fromJson(response.data);
    await _storage.token.set(token);
  }
}

import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_storage.dart';

@lazySingleton
class TokenStorage {
  TokenStorage(this._box);

  final Box _box;
  final String accessToken = "key_access_token";
  final String isLoginKey = "key_login_in";

  BaseStorage<String> get token => BaseStorage(_box, key: accessToken);

  BaseStorage<bool> get isLogin => BaseStorage(_box, key: isLoginKey);

  @FactoryMethod(preResolve: true)
  static Future<TokenStorage> create() async {
    final box = await Hive.openBox('token_storage');
    return TokenStorage(box);
  }
}

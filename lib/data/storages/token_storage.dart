import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/box_value.dart';

@lazySingleton
class TokenStorage {
  TokenStorage(this._box);

  static const String STORAGE_BOX_NAME = "token_storage";
  final String KEY_ACCESS_TOKEN = "string_access_token";
  final String KEY_IS_LOGIN = "bool_login_in";

  final Box _box;

  @FactoryMethod(preResolve: true)
  static Future<TokenStorage> create() async {
    final box = await Hive.openBox(STORAGE_BOX_NAME);
    return TokenStorage(box);
  }

  BoxValue<String> get _tokenBox => BoxValue(_box, key: KEY_ACCESS_TOKEN);

  String get token => _tokenBox.getOrNull() ?? "";

  Future<void> setToken(String token) => _tokenBox.set(token);

  BoxValue<bool> get _loginStateBox => BoxValue(_box, key: KEY_IS_LOGIN);

  bool get isUserLoggedIn => _loginStateBox.getOrNull() ?? false;

  Future<void> setLoginState(bool isLogin) => _loginStateBox.set(isLogin);

  Future<void> clear() async {
    await _tokenBox.clear();
    await _loginStateBox.clear();
  }
}

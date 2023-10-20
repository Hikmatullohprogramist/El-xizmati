import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../common/base/base_storage.dart';

@lazySingleton
class TokenStorage {
  TokenStorage(this._box);

  final Box _box;
  final String accessToken = "key_token_sto";

  BaseStorage<String> get token => BaseStorage(_box, key: accessToken);

  @FactoryMethod(preResolve: true)
  static Future<TokenStorage> create() async {
    final box = await Hive.openBox('token_storage');
    return TokenStorage(box);
  }
}

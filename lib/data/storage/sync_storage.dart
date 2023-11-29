import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../common/core/base_storage.dart';

@lazySingleton
class SyncStorage {
  SyncStorage(this._box);

  final Box _box;
  final String keyFavoriteSync = "key_is_favorite_storage";
  final String keyCartSync = "key_is_cart_storage";

  BaseStorage<bool> get isFavoriteSync =>
      BaseStorage(_box, key: keyFavoriteSync);

  BaseStorage<bool> get isCartSync => BaseStorage(_box, key: keyCartSync);

  @FactoryMethod(preResolve: true)
  static Future<SyncStorage> create() async {
    final box = await Hive.openBox('sync_storage');
    return SyncStorage(box);
  }
}

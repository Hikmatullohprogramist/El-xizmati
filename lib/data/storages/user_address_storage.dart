import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/hive_objects/user_address/user_address_hive_object.dart';

import '../../common/core/box_value.dart';

@lazySingleton
class CacheStorage {
  CacheStorage(this._box);

  static const String STORAGE_BOX_NAME = "user_address_storage";
  final String KEY_ADDRESSES = "json_addresses";

  final Box _box;

  @FactoryMethod(preResolve: true)
  static Future<CacheStorage> create() async {
    final box = await Hive.openBox(STORAGE_BOX_NAME);
    return CacheStorage(box);
  }

  BoxValue get storage => BoxValue(_box, key: KEY_ADDRESSES);

  List<UserAddressHiveObject> get userAddresses =>
      _box.values.toList().cast<UserAddressHiveObject>();
}

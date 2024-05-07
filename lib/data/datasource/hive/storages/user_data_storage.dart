import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/hive/constants/hive_constants.dart';
import 'package:onlinebozor/data/datasource/hive/core/box_value.dart';
import 'package:onlinebozor/data/datasource/hive/hive_objects/user_data/user_address_hive_object.dart';
import 'package:path_provider/path_provider.dart';

@lazySingleton
class UserDataStorage {
  UserDataStorage(this._box);

  static const String STORAGE_BOX_NAME = "user_data_storage";
  final String KEY_ADDRESSES = "json_addresses";

  final Box _box;

  @FactoryMethod(preResolve: true)
  static Future<UserDataStorage> create() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    if (!Hive.isAdapterRegistered(HiveConstants.USER_ADDRESS_TYPE_ID)) {
      Hive
        ..init(appDocumentDir.path)
        ..registerAdapter(UserAddressHiveObjectAdapter());
    }
    final box = await Hive.openBox(STORAGE_BOX_NAME);
    return UserDataStorage(box);
  }

  BoxValue<List<UserAddressHiveObject>> get _addressesBox =>
      BoxValue(_box, key: KEY_ADDRESSES);

  List<UserAddressHiveObject> get userAddresses =>
      _addressesBox.getOrNull() ?? [];

  Future<void> setAddresses(List<UserAddressHiveObject> addresses) =>
      _addressesBox.set(addresses);

  Future<void> clear() async {
    await _addressesBox.clear();
  }
}

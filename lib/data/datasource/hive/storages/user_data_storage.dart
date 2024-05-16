import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/extensions/list_extensions.dart';
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

  BoxValue<UserAddressHiveObject> get _addressesBox =>
      BoxValue(_box, key: KEY_ADDRESSES);

  List<UserAddressHiveObject> get userAddresses => _addressesBox.values();

  bool get hasSavedAddresses => userAddresses.isNotEmpty;

  int indexOf(int adId) => userAddresses.indexIf((e) => e.id == adId);

  Future<void> upsert(UserAddressHiveObject address) async {
    final index = indexOf(address.id);
    if (index >= 0) {
      _addressesBox.update(index, address);
    } else {
      _addressesBox.add(address);
    }
  }

  Future<void> add(UserAddressHiveObject address) async {
    _addressesBox.add(address);
  }

  Future<void> update(UserAddressHiveObject address) async {
    final index = indexOf(address.id);
    _addressesBox.update(index, address);
  }

  Future<void> delete(UserAddressHiveObject address) async {
    final index = indexOf(address.id);
    if (index >= 0) {
      _addressesBox.deleteAt(index);
    }
  }

  Future<void> setAddresses(List<UserAddressHiveObject> addresses) =>
      _addressesBox.addAll(addresses);

  Future<void> clear() async {
    await _addressesBox.clear();
  }
}

import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/box_value.dart';
import 'package:path_provider/path_provider.dart';

import '../hive_objects/user/user_hive_object.dart';

@lazySingleton
class UserStorage {
  UserStorage(this._box);

  static const String STORAGE_BOX_NAME = "user_storage";
  final String KEY_USER = "json_user";

  final Box _box;

  @FactoryMethod(preResolve: true)
  static Future<UserStorage> create() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    if (!Hive.isAdapterRegistered(4)) {
      Hive
        ..init(appDocumentDir.path)
        ..registerAdapter(UserHiveObjectAdapter());
    }
    final box = await Hive.openBox(STORAGE_BOX_NAME);
    return UserStorage(box);
  }

  BoxValue<UserHiveObject> get _userBox => BoxValue(_box, key: KEY_USER);

  UserHiveObject? get user => _userBox.getOrNull();

  bool get isIdentityVerified => user?.isIdentityVerified ?? false;

  int? get tin => user?.tin;

  int? get pinfl => user?.pinfl;

  Future<void> set(UserHiveObject user) => _userBox.set(user);

  Future<void> clear() => _userBox.clear();
}

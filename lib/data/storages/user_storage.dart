import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_storage.dart';
import 'package:path_provider/path_provider.dart';

import '../hive_objects/user/user_info_object.dart';

@lazySingleton
class UserInfoStorage {
  UserInfoStorage(this._box);

  final Box _box;

  BaseStorage<UserInfoObject> get userInformation =>
      BaseStorage(_box, key: "key_user_info_storage");

  @FactoryMethod(preResolve: true)
  static Future<UserInfoStorage> create() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    if (!Hive.isAdapterRegistered(4)) {
      Hive
        ..init(appDocumentDir.path)
        ..registerAdapter(UserInfoObjectAdapter());
    }
    final box = await Hive.openBox('user_info_storage');
    return UserInfoStorage(box);
  }

  Future<void> update(UserInfoObject userInfoObject) async {
    UserInfoObject? userInfo = _box.get("key_user_info_storage");
    if (userInfo != null) {
      _box.put("key_user_info_storage", userInfoObject);
    } else {
      _box.put("key_user_info_storage", userInfoObject);
    }
  }
}

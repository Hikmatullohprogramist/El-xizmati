import 'package:get_it/get_it.dart';
import 'package:onlinebozor/data/datasource/floor/constants/floor_names.dart';
import 'package:onlinebozor/data/datasource/floor/dao/ad_entity_dao.dart';
import 'package:onlinebozor/data/datasource/floor/dao/category_entity_dao.dart';
import 'package:onlinebozor/data/datasource/floor/dao/user_address_entity_dao.dart';
import 'package:onlinebozor/data/datasource/floor/dao/user_entity_dao.dart';
import 'package:onlinebozor/data/datasource/floor/database/app_database.dart';

extension GetItModuleDatabase on GetIt {
  Future<void> databaseModule() async {
    registerSingletonAsync<AppDatabase>(() async => $FloorAppDatabase
        .databaseBuilder(FLOOR_APP_DATABASE_NAME)
        // .addCallback(callback)
        .build());

    registerSingletonWithDependencies<AdEntityDao>(
      () => get<AppDatabase>().adEntityDao,
      dependsOn: [AppDatabase],
    );

    registerSingletonWithDependencies<CategoryEntityDao>(
      () => get<AppDatabase>().categoryEntityDao,
      dependsOn: [AppDatabase],
    );

    registerSingletonWithDependencies<UserAddressEntityDao>(
      () => get<AppDatabase>().userAddressEntityDao,
      dependsOn: [AppDatabase],
    );

    registerSingletonWithDependencies<UserEntityDao>(
      () => get<AppDatabase>().userEntityDao,
      dependsOn: [AppDatabase],
    );

    await allReady();
  }
}

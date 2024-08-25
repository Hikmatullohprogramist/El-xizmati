import 'package:get_it/get_it.dart';
import 'package:El_xizmati/data/datasource/floor/dao/ad_entity_dao.dart';
import 'package:El_xizmati/data/datasource/floor/dao/category_entity_dao.dart';
import 'package:El_xizmati/data/datasource/floor/dao/user_address_entity_dao.dart';
import 'package:El_xizmati/data/datasource/floor/dao/user_entity_dao.dart';
import 'package:El_xizmati/data/datasource/floor/database/app_database.dart';

extension GetItModuleDatabase on GetIt {
  Future<void> databaseModule() async {
    registerSingletonAsync<AppDatabase>(
      () async => await AppDatabase.initializeDatabase(),
    );

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

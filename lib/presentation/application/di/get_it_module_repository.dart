import 'package:get_it/get_it.dart';
import 'package:El_xizmati/data/repositories/ad_creation_repository.dart';
import 'package:El_xizmati/data/repositories/ad_repository.dart';
import 'package:El_xizmati/data/repositories/auth_repository.dart';
import 'package:El_xizmati/data/repositories/billing_repository.dart';
import 'package:El_xizmati/data/repositories/card_repositroy.dart';
import 'package:El_xizmati/data/repositories/cart_repository.dart';
import 'package:El_xizmati/data/repositories/common_repository.dart';
import 'package:El_xizmati/data/repositories/eds_repository.dart';
import 'package:El_xizmati/data/repositories/favorite_repository.dart';
import 'package:El_xizmati/data/repositories/identity_repository.dart';
import 'package:El_xizmati/data/repositories/language_repository.dart';
import 'package:El_xizmati/data/repositories/merchant_repository.dart';
import 'package:El_xizmati/data/repositories/notification_repository.dart';
import 'package:El_xizmati/data/repositories/region_repository.dart';
import 'package:El_xizmati/data/repositories/report_repository.dart';
import 'package:El_xizmati/data/repositories/state_repository.dart';
import 'package:El_xizmati/data/repositories/theme_mode_repository.dart';
import 'package:El_xizmati/data/repositories/user_ad_repository.dart';
import 'package:El_xizmati/data/repositories/user_address_repository.dart';
import 'package:El_xizmati/data/repositories/user_order_repository.dart';
import 'package:El_xizmati/data/repositories/user_repository.dart';

extension GetItModuleExtension on GetIt {
  Future<void> repositoryModule() async {
    registerLazySingleton(() => StateRepository(get(), get()));

    registerLazySingleton(() => LanguageRepository(get(), get(), get()));

    registerLazySingleton(() => AdCreationRepository(get(), get(), get()));
    registerLazySingleton(
      () => AdRepository(get(), get(), get(), get(), get(), get()),
    );
    registerLazySingleton(
      () => AuthRepository(get(), get(), get(), get(), get(), get(), get()),
    );

    registerLazySingleton(() => BillingRepository(get(), get(), get()));

    registerLazySingleton(() => CardRepository(get(), get(), get()));
    registerLazySingleton(() => CartRepository(get(), get(), get()));
    registerLazySingleton(() => CommonRepository(get(), get()));

    registerLazySingleton(() => EdsRepository(get(), get(), get(), get()));

    registerLazySingleton(() => FavoriteRepository(get(), get(), get()));

    registerLazySingleton(() => IdentityRepository(get(), get()));

    registerLazySingleton(() => MerchantRepository(get(), get(), get(), get()));

    registerLazySingleton(() => NotificationRepository(get(), get()));

    registerLazySingleton(() => RegionRepository(get(), get()));
    registerLazySingleton(() => ReportRepository(get()));

    registerLazySingleton(() => ThemeModeRepository(get()));

    registerLazySingleton(() => UserAdRepository(get(), get(), get()));
    registerLazySingleton(
      () => UserAddressRepository(get(), get(), get(), get()),
    );
    registerLazySingleton(
      () => UserOrderRepository(get(), get(), get(), get(), get()),
    );
    registerLazySingleton(() => UserRepository(get(), get(), get(), get()));

    await allReady();
  }
}

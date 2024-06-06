import 'package:get_it/get_it.dart';
import 'package:onlinebozor/data/repositories/ad_creation_repository.dart';
import 'package:onlinebozor/data/repositories/ad_repository.dart';
import 'package:onlinebozor/data/repositories/auth_repository.dart';
import 'package:onlinebozor/data/repositories/card_repositroy.dart';
import 'package:onlinebozor/data/repositories/cart_repository.dart';
import 'package:onlinebozor/data/repositories/common_repository.dart';
import 'package:onlinebozor/data/repositories/favorite_repository.dart';
import 'package:onlinebozor/data/repositories/order_repository.dart';
import 'package:onlinebozor/data/repositories/payment_repository.dart';
import 'package:onlinebozor/data/repositories/report_repository.dart';
import 'package:onlinebozor/data/repositories/state_repository.dart';
import 'package:onlinebozor/data/repositories/user_ad_repository.dart';
import 'package:onlinebozor/data/repositories/user_address_repository.dart';
import 'package:onlinebozor/data/repositories/user_order_repository.dart';
import 'package:onlinebozor/data/repositories/user_repository.dart';

extension GetItModuleExtension on GetIt {
  Future<void> repositoryModule() async {
    registerLazySingleton(() => StateRepository(get(), get(), get()));
    registerLazySingleton(() => AdCreationRepository(get(), get(), get()));
    registerLazySingleton(() => AdRepository(get(), get(), get(), get()));
    registerLazySingleton(
      () => AuthRepository(get(), get(), get(), get(), get()),
    );
    registerLazySingleton(() => CardRepository(get(), get(), get(), get()));
    registerLazySingleton(() => CartRepository(get(), get(), get()));
    registerLazySingleton(() => CommonRepository(get(), get()));
    registerLazySingleton(() => FavoriteRepository(get(), get(), get(), get()));
    registerLazySingleton(
      () => OrderRepository(get(), get(), get(), get(), get()),
    );
    registerLazySingleton(() => PaymentRepository(get(), get(), get(), get()));
    registerLazySingleton(() => ReportRepository(get()));
    registerLazySingleton(() => UserAdRepository(get(), get(), get()));
    registerLazySingleton(
      () => UserAddressRepository(get(), get(), get(), get()),
    );
    registerLazySingleton(() => UserOrderRepository(get(), get(), get()));
    registerLazySingleton(() => UserRepository(get(), get(), get()));
    await allReady();
  }
}

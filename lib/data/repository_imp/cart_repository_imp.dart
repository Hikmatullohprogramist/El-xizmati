import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/repository/cart_repository.dart';

@LazySingleton(as: CartRepository)
class CartRepositoryImp extends CartRepository {
  // final CartApi cartApi;

// CartRepositoryImp(this.cartApi);
//
// @override
// Future<void> addCart(AdModel adModel) async {}
//
// @override
// Future<void> deleteCart(int adId) {}
//
// @override
// Future<List<AdModel>> getCartAds() {}
}

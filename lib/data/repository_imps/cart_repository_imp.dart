import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/data/responses/add_result/add_result_response.dart';
import 'package:onlinebozor/data/services/cart_service.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';

import '../../domain/models/ad.dart';
import '../../domain/repositories/cart_repository.dart';
import '../responses/ad/ad/ad_response.dart';
import '../storages/cart_storage.dart';
import '../storages/favorite_storage.dart';
import '../storages/sync_storage.dart';
import '../storages/token_storage.dart';

@LazySingleton(as: CartRepository)
class CartRepositoryImp extends CartRepository {
  final CartService _cartService;
  final CartStorage cartStorage;
  final TokenStorage tokenStorage;
  final FavoriteStorage favoriteStorage;
  final SyncStorage syncStorage;

  CartRepositoryImp(this._cartService, this.cartStorage, this.tokenStorage,
      this.favoriteStorage, this.syncStorage);

  @override
  Future<int> addCart(Ad ad) async {
    final isLogin = tokenStorage.isLogin.call() ?? false;
    int resultId = ad.id;
    if (isLogin) {
      final response =
          await _cartService.addCart(adType: ad.adStatusType.name, id: ad.id);
      final addResultId =
          AddResultRootResponse.fromJson(response.data).data?.products?.id;
      resultId = addResultId ?? ad.id;
    }
    final allItem = cartStorage.allItems.map((e) => e.toMap()).toList();
    if (allItem.where((element) => element.id == ad.id).isEmpty) {
      cartStorage.cartStorage.add(ad.toMap(backendId: resultId));
    } else {
      final index = allItem.indexOf(ad);
      cartStorage.update(index, ad.toMap(backendId: resultId));
    }
    return resultId;
  }

  @override
  Future<void> removeCart(Ad ad) async {
    final isLogin = tokenStorage.isLogin.call() ?? false;
    if (isLogin) {
      await _cartService.removeCart(adId: ad.backendId ?? ad.id);
      cartStorage.removeCart(ad.id);
    } else {
      cartStorage.removeCart(ad.id);
      await syncStorage.isFavoriteSync.set(false);
    }
  }

  @override
  Future<List<Ad>> getCartAds() async {
    final logger = Logger();
    logger.w("getFavorites Ads");
    try {
      final isLogin = tokenStorage.isLogin.call() ?? false;
      if (isLogin) {
        final response = await _cartService.getCartAllAds();
        final cartAds = AdRootResponse.fromJson(response.data)
            .data
            .results
            .map((e) => e.toMap(favorite: true));
        final allItem = cartStorage.allItems.map((e) => e.toMap()).toList();
        for (var item in cartAds) {
          if (allItem.where((element) => element.id == item.id).isEmpty) {
            cartStorage.cartStorage.add(item.toMap(favorite: true));
          }
        }
      }
      final favoriteAds = favoriteStorage.allItems;
      final cartAds = cartStorage.allItems;
      logger.e("  ${cartAds.toString()}");
      return cartAds
          .map((cartItem) => cartItem.toMap(
              favorite: favoriteAds
                  .where((element) => cartItem.id == element.id)
                  .isNotEmpty))
          .toList();
    } catch (e) {
      logger.e(e.toString());
      return List.empty();
    }
  }

  @override
  Future<void> orderCreate(
      {required int productId,
      required int amount,
      required int paymentTypeId,
      required int tin}) async {
    _cartService.orderCreate(
        productId: productId,
        amount: amount,
        paymentTypeId: paymentTypeId,
        tin: tin);
    return;
  }
}

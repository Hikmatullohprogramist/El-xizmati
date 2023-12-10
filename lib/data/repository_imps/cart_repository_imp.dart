import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/data/services/cart_service.dart';
import 'package:onlinebozor/domain/mappers/ad_enum_mapper.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';

import '../../domain/models/ad.dart';
import '../../domain/repositories/cart_repository.dart';
import '../hive_objects/ad/ad_object.dart';
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
  Future<void> addCart(Ad ad) async {
    final isLogin = tokenStorage.isLogin.call() ?? false;
    if (isLogin) {
      await _cartService.addCart(adType: ad.adStatusType.name, id: ad.id);
    }
    final allItem = cartStorage.allItems.map((e) => e.toMap()).toList();
    if (allItem.where((element) => element.id == ad.id).isEmpty) {
      cartStorage.cartStorage.add(AdObject(
          id: ad.id,
          name: ad.name,
          price: ad.price,
          currency: ad.currency.currencyToString(),
          region: ad.region,
          district: ad.district,
          adRouteType: ad.adRouteType.adRouteTypeToString(),
          adPropertyStatus: ad.adPropertyStatus.adPropertyStatusToString(),
          adStatusType: ad.adStatusType.adStatusTypeToString(),
          adTypeStatus: ad.adTypeStatus.adTypeStatusToString(),
          fromPrice: ad.fromPrice,
          toPrice: ad.toPrice,
          categoryId: ad.categoryId,
          categoryName: ad.categoryName,
          isSort: ad.isSort,
          isSell: ad.isSell,
          isCheck: ad.isCheck,
          sellerId: ad.sellerId,
          maxAmount: ad.maxAmount,
          favorite: true,
          photo: ad.photo,
          sellerName: ad.sellerName,
          backendId: ad.backendId));
    }
    return;
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
            cartStorage.cartStorage.add(AdObject(
                id: item.id,
                name: item.name,
                price: item.price,
                currency: item.currency.currencyToString(),
                region: item.region,
                district: item.district,
                adRouteType: item.adRouteType.adRouteTypeToString(),
                adPropertyStatus:
                    item.adPropertyStatus.adPropertyStatusToString(),
                adStatusType: item.adStatusType.adStatusTypeToString(),
                adTypeStatus: item.adTypeStatus.adTypeStatusToString(),
                fromPrice: item.fromPrice,
                toPrice: item.toPrice,
                categoryId: item.categoryId,
                categoryName: item.categoryName,
                isSort: item.isSort,
                isSell: item.isSell,
                isCheck: item.isCheck,
                sellerId: item.sellerId,
                maxAmount: item.maxAmount,
                favorite: true,
                photo: item.photo,
                sellerName: item.sellerName,
                backendId: item.backendId));
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

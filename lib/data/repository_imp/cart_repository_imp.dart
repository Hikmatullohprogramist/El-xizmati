import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/data/model/ad/ad/ad_response.dart';
import 'package:onlinebozor/domain/mapper/ad_enum_mapper.dart';
import 'package:onlinebozor/domain/mapper/ad_mapper.dart';
import 'package:onlinebozor/domain/repository/cart_repository.dart';

import '../../domain/model/ad.dart';
import '../api/cart_api.dart';
import '../hive_object/ad/ad_object.dart';
import '../storage/cart_storage.dart';
import '../storage/favorite_storage.dart';
import '../storage/sync_storage.dart';
import '../storage/token_storage.dart';

@LazySingleton(as: CartRepository)
class CartRepositoryImp extends CartRepository {
  final CartApi _api;
  final CartStorage cartStorage;
  final TokenStorage tokenStorage;
  final FavoriteStorage favoriteStorage;
  final SyncStorage syncStorage;

  CartRepositoryImp(this._api, this.cartStorage, this.tokenStorage,
      this.favoriteStorage, this.syncStorage);

  @override
  Future<void> addCart(Ad adModel) async {
    final isLogin = tokenStorage.isLogin.call() ?? false;
    if (isLogin) {
      await _api.addCart(adType: adModel.adStatusType.name, id: adModel.id);
    }
    final allItem = cartStorage.allItems.map((e) => e.toMap()).toList();
    if (allItem.where((element) => element.id == adModel.id).isEmpty) {
      cartStorage.cartStorage.add(AdObject(
          id: adModel.id,
          name: adModel.name,
          price: adModel.price,
          currency: adModel.currency.currencyToString(),
          region: adModel.region,
          district: adModel.district,
          adRouteType: adModel.adRouteType.adRouteTypeToString(),
          adPropertyStatus: adModel.adPropertyStatus.adPropertyStatusToString(),
          adStatusType: adModel.adStatusType.adStatusTypeToString(),
          adTypeStatus: adModel.adTypeStatus.adTypeStatusToString(),
          fromPrice: adModel.fromPrice,
          toPrice: adModel.toPrice,
          categoryId: adModel.categoryId,
          categoryName: adModel.categoryName,
          isSort: adModel.isSort,
          isSell: adModel.isSell,
          isCheck: adModel.isCheck,
          sellerId: adModel.sellerId,
          maxAmount: adModel.maxAmount,
          favorite: true,
          photo: adModel.photo,
          sellerName: adModel.sellerName,
          backendId: adModel.backendId));
    }
    return;
  }

  @override
  Future<void> removeCart(int adId) async {
    final isLogin = tokenStorage.isLogin.call() ?? false;
    if (isLogin) {
      await _api.removeCart(adId: adId);
      cartStorage.removeCart(adId);
    } else {
      cartStorage.removeCart(adId);
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
        final response = await _api.getCartAllAds();
        final cartAds = (AdRootResponse.fromJson(response.data).data?.results ??
                List.empty())
            .map((e) => e.toMap(favorite: true));
        final allItem = cartStorage.allItems.map((e) => e.toMap()).toList();
        for (var item in cartAds) {
          if (allItem.where((element) => element.id == item.id).isEmpty) {
            favoriteStorage.favoriteAds.add(AdObject(
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
    _api.orderCreate(
        productId: productId,
        amount: amount,
        paymentTypeId: paymentTypeId,
        tin: tin);
    return;
  }
}

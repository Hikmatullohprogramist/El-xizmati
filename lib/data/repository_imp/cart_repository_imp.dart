import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/domain/mapper/ad_enum_mapper.dart';
import 'package:onlinebozor/domain/mapper/ad_mapper.dart';
import 'package:onlinebozor/domain/repository/cart_repository.dart';

import '../../domain/model/ad_model.dart';
import '../api/cart_api.dart';
import '../hive_object/ad_hive_object.dart';
import '../storage/cart_storage.dart';
import '../storage/favorite_storage.dart';
import '../storage/token_storage.dart';

@LazySingleton(as: CartRepository)
class CartRepositoryImp extends CartRepository {
  final CartApi _api;
  final CartStorage cartStorage;
  final TokenStorage tokenStorage;
  final FavoriteStorage favoriteStorage;

  CartRepositoryImp(
      this._api, this.cartStorage, this.tokenStorage, this.favoriteStorage);

  @override
  Future<void> addCart(AdModel adModel) async {
    final isLogin = tokenStorage.isLogin.call() ?? false;
    if (isLogin) {
      // await _api.addFavorite(adType: adModel.adStatusType.name, id: adModel.id);
    }
    final allItem = cartStorage.allItems.map((e) => e.toMap()).toList();
    if (allItem.where((element) => element.id == adModel.id).isEmpty) {
      cartStorage.cartStorage.add(AdHiveObject(
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
          sellerName: adModel.sellerName));
    }
    return;
  }

  // @override
  // Future<void> removeCart(int adId) async {
  //   cartStorage.removeCart(adId);
  //   // final isLogin = tokenStorage.isLogin.call() ?? false;
  //   // if (isLogin) {
  //   //   await _api.deleteFavorite();
  //   // } else {}
  // }

  @override
  Future<void> removeCart(int adId) async {
    cartStorage.removeCart(adId);
  }

  @override
  Future<List<AdModel>> getCartAds() async {
    final logger = Logger();
    logger.w("getFavorites Ads");
    try {
      final favoriteAds = favoriteStorage.allItems;
      final result = cartStorage.allItems;
      logger.e("  ${result.toString()}");
      return result
          .map((item) => item.toMap(
              favorite: favoriteAds
                  .where((element) => item.id == element.id)
                  .isNotEmpty))
          .toList();
    } catch (e) {
      logger.e(e.toString());
      return List.empty();
    }
  }
}

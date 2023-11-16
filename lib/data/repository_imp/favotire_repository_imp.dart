import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/data/api/favorite_api.dart';
import 'package:onlinebozor/data/hive_object/ad_hive_object.dart';
import 'package:onlinebozor/domain/mapper/ad_enum_mapper.dart';
import 'package:onlinebozor/domain/mapper/ad_mapper.dart';
import 'package:onlinebozor/domain/model/ad_model.dart';
import 'package:onlinebozor/domain/repository/favorite_repository.dart';

import '../storage/favorite_storage.dart';
import '../storage/token_storage.dart';

@LazySingleton(as: FavoriteRepository)
class FavoriteRepositoryImp extends FavoriteRepository {
  final FavoriteApi _api;
  final TokenStorage tokenStorage;
  final FavoriteStorage favoriteStorage;

  FavoriteRepositoryImp(
    this._api,
    this.tokenStorage,
    this.favoriteStorage,
  );

  @override
  Future<void> addFavorite(AdModel adModel) async {
    favoriteStorage.categoriesStorage.add(AdHiveObject(
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
    // final isLogin = tokenStorage.isLogin.call() ?? false;
    // // if (isLogin) {
    // await _api.addFavorite(adType: adModel.adStatusType.name, id: adModel.id);
    // // } else {
    // //     add local storage;
    // // }
    return;
  }

  @override
  Future<void> deleteFavorite(int adId) async {
    favoriteStorage.delete(adId);
    // final isLogin = tokenStorage.isLogin.call() ?? false;
    // favoriteStorage.categoriesStorage.delete();
    // if (isLogin) {
    //   await _api.deleteFavorite();
    // } else {}
  }

  @override
  Future<List<AdModel>> getFavoriteAds() async {
    final logger = Logger();
    logger.w("getFavorites Ads");
    try {
      final result = favoriteStorage.allItems;
      return result.map((e) => e.toMap()).toList();
    } catch (e) {
      logger.e(e.toString());
      return List.empty();
    }
    // final isLogin = tokenStorage.isLogin.call() ?? false;
    // if (isLogin) {
    //   final response = await _api.getFavoriteAds();
    //   final adsResponse =
    //       AdRootResponse.fromJson(response.data).data?.results ?? List.empty();
    //   final result = adsResponse
    //       .map((e) => e.toMap(favorite: true))
    //       .toList(growable: true);
    //   return result;
    // } else {
    //   return List.empty();
    // }
  }
}

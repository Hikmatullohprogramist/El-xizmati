import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/data/api/favorite_api.dart';
import 'package:onlinebozor/data/hive_object/ad/ad_object.dart';
import 'package:onlinebozor/data/model/ads/ad/ad_response.dart';
import 'package:onlinebozor/data/storage/sync_storage.dart';
import 'package:onlinebozor/domain/mapper/ad_enum_mapper.dart';
import 'package:onlinebozor/domain/mapper/ad_mapper.dart';
import 'package:onlinebozor/domain/model/ad.dart';
import 'package:onlinebozor/domain/repository/favorite_repository.dart';

import '../storage/favorite_storage.dart';
import '../storage/token_storage.dart';

@LazySingleton(as: FavoriteRepository)
class FavoriteRepositoryImp extends FavoriteRepository {
  final FavoriteApi _api;
  final TokenStorage tokenStorage;
  final FavoriteStorage favoriteStorage;
  final SyncStorage syncStorage;

  FavoriteRepositoryImp(
    this._api,
    this.tokenStorage,
    this.favoriteStorage,
    this.syncStorage,
  );

  @override
  Future<void> addFavorite(Ad adModel) async {
    final isLogin = tokenStorage.isLogin.call() ?? false;
    if (isLogin) {
      await _api.addFavorite(adType: adModel.adStatusType.name, id: adModel.id);
    } else {
      await syncStorage.isFavoriteSync.set(false);
    }
    final allItem = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    if (allItem.where((element) => element.id == adModel.id).isEmpty) {
      favoriteStorage.favoriteAds.add(AdObject(
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

  @override
  Future<void> removeFavorite(int adId) async {
    favoriteStorage.removeFavorite(adId);
    final isLogin = tokenStorage.isLogin.call() ?? false;
    if (isLogin) {
      await _api.deleteFavorite(adId);
    } else {
      await syncStorage.isFavoriteSync.set(false);
    }
  }

  @override
  Future<List<Ad>> getFavoriteAds() async {
    try {
      final isLogin = tokenStorage.isLogin.call() ?? false;
      if (isLogin) {
        final response = await _api.getFavoriteAds();
        final allRemoteAds =
            (AdRootResponse.fromJson(response.data).data?.results ??
                    List.empty())
                .map((e) => e.toMap(favorite: true));
        final allItem = favoriteStorage.allItems.map((e) => e.toMap()).toList();
        for (var item in allRemoteAds) {
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
                sellerName: item.sellerName));
          }
        }
      }
      final result = favoriteStorage.allItems;
      return result.map((e) => e.toMap(favorite: true)).toList();
    } catch (e) {
      return List.empty();
    }
  }

  @override
  Future<void> pushAllFavoriteAds() async {
    try {
      final log=Logger();
      final allItem = favoriteStorage.allItems.map((e) => e.toMap()).toList();
      log.e(allItem.toString());
      await _api.sendAllFavoriteAds(allItem);
      await syncStorage.isFavoriteSync.set(true);
    } catch (e) {
      rethrow;
    }
  }
}

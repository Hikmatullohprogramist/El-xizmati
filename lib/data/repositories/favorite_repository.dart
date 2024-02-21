import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/data/responses/add_result/add_result_response.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';

import '../../data/responses/ad/ad/ad_response.dart';
import '../../data/services/ad_service.dart';
import '../../data/services/favorite_service.dart';
import '../../data/storages/favorite_storage.dart';
import '../../data/storages/sync_storage.dart';
import '../../data/storages/token_storage.dart';
import '../../domain/models/ad/ad.dart';
import '../../domain/models/ad/ad_transaction_type.dart';

@LazySingleton()
class FavoriteRepository {
  final FavoriteService _favoriteService;
  final TokenStorage tokenStorage;
  final FavoriteStorage favoriteStorage;
  final SyncStorage syncStorage;
  final AdsService adService;

  FavoriteRepository(
    this._favoriteService,
    this.tokenStorage,
    this.favoriteStorage,
    this.syncStorage,
    this.adService,
  );

  Future<int> addFavorite(Ad ad) async {
    final isLogin = tokenStorage.isLogin.call() ?? false;
    int resultId = ad.id;
    if (isLogin) {
      // await adService.setViewAd(type: ViewType.selected, adId: ad.id);
      final response = await _favoriteService.addFavorite(
          adType: ad.adStatus.name, id: ad.id);
      final addResultId =
          AddResultRootResponse.fromJson(response.data).data?.products?.id;
      resultId = addResultId ?? ad.id;
    } else {
      await syncStorage.isFavoriteSync.set(false);
    }
    final allItem =
        favoriteStorage.allItems.map((item) => item.toMap()).toList();
    if (allItem.where((element) => element.id == ad.id).isEmpty) {
      favoriteStorage.favoriteAds
          .add(ad.toMap(favorite: true, backendId: resultId));
    } else {
      final index = allItem.indexOf(ad);
      favoriteStorage.update(
          index, ad.toMap(favorite: true, backendId: resultId));
    }
    return resultId;
  }

  Future<void> removeFavorite(Ad ad) async {
    favoriteStorage.removeFavorite(ad.id);
    final isLogin = tokenStorage.isLogin.call() ?? false;
    if (isLogin) {
      await _favoriteService.deleteFavorite(ad.id);
    } else {
      await syncStorage.isFavoriteSync.set(false);
    }
  }

  Future<List<Ad>> getProductFavoriteAds() async {
    try {
      final isLogin = tokenStorage.isLogin.call() ?? false;
      if (isLogin) {
        final response = await _favoriteService.getFavoriteAds();
        final allRemoteAds = AdRootResponse.fromJson(response.data)
            .data
            .results
            .map((item) => item.toMap(favorite: true));
        final allItem =
            favoriteStorage.allItems.map((item) => item.toMap()).toList();
        for (var item in allRemoteAds) {
          if (allItem.where((element) => element.id == item.id).isEmpty) {
            favoriteStorage.favoriteAds.add(item.toMap(favorite: true));
          }
        }
      }
      final result = favoriteStorage.allItems;
      return result
          .map((item) => item.toMap(favorite: true))
          .where((element) => (element.adTypeStatus == AdTransactionType.sell ||
              element.adTypeStatus == AdTransactionType.free ||
              element.adTypeStatus == AdTransactionType.exchange ||
              element.adTypeStatus == AdTransactionType.buy))
          .toList();
    } catch (e) {
      return List.empty();
    }
  }

  Future<List<Ad>> getServiceFavoriteAds() async {
    try {
      final isLogin = tokenStorage.isLogin.call() ?? false;
      if (isLogin) {
        final response = await _favoriteService.getFavoriteAds();
        final allRemoteAds = AdRootResponse.fromJson(response.data)
            .data
            .results
            .map((e) => e.toMap(favorite: true));
        final allItem = favoriteStorage.allItems.map((e) => e.toMap()).toList();
        for (var item in allRemoteAds) {
          if (allItem.where((element) => element.id == item.id).isEmpty) {
            favoriteStorage.favoriteAds.add(item.toMap(favorite: true));
          }
        }
      }
      final result = favoriteStorage.allItems;
      return result
          .map((e) => e.toMap(favorite: true))
          .where((element) =>
              (element.adTypeStatus == AdTransactionType.service ||
                  element.adTypeStatus == AdTransactionType.buyService))
          .toList();
    } catch (e) {
      return List.empty();
    }
  }

  Future<void> pushAllFavoriteAds() async {
    final log = Logger();
    try {
      final allItem = favoriteStorage.allItems.map((e) => e.toMap()).toList();
      log.e(allItem.toString());
      await _favoriteService.sendAllFavoriteAds(allItem);
      await syncStorage.isFavoriteSync.set(true);
    } catch (e) {
      log.e(e.toString());
    }
  }
}

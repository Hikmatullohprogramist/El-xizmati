import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/data/datasource/hive/storages/favorite_storage.dart';
import 'package:onlinebozor/data/datasource/hive/storages/token_storage.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/ad/ad_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/add_result/add_result_response.dart';
import 'package:onlinebozor/data/datasource/network/services/ad_service.dart';
import 'package:onlinebozor/data/datasource/network/services/favorite_service.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';

import '../../domain/models/ad/ad.dart';
import '../../domain/models/ad/ad_transaction_type.dart';

@LazySingleton()
class FavoriteRepository {
  final FavoriteService _favoriteService;
  final TokenStorage tokenStorage;
  final FavoriteStorage favoriteStorage;
  final AdsService adService;

  FavoriteRepository(
    this._favoriteService,
    this.tokenStorage,
    this.favoriteStorage,
    // this.syncStorage,
    this.adService,
  );

  Future<int> addToFavorite(Ad ad) async {
    final isLogin = tokenStorage.isUserLoggedIn;
    int resultId = ad.id;
    if (isLogin) {
      final response = await _favoriteService.addToFavorite(adId: ad.id);
      final addResultId =
          AddResultRootResponse.fromJson(response.data).data?.products?.id;
      resultId = addResultId ?? ad.id;
    } else {
      // await syncStorage.isFavoriteSync.set(false);
    }
    final allItem = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    if (allItem.where((e) => e.id == ad.id).isEmpty) {
      favoriteStorage.favoriteAds
          .add(ad.toMap(isFavorite: true, backendId: resultId));
    } else {
      final index = allItem.indexOf(ad);
      favoriteStorage.update(
          index, ad.toMap(isFavorite: true, backendId: resultId));
    }
    return resultId;
  }

  Future<void> removeFromFavorite(int adId) async {
    favoriteStorage.removeFromFavorite(adId);
    final isLogin = tokenStorage.isUserLoggedIn;
    if (isLogin) {
      await _favoriteService.removeFromFavorite(adId);
    } else {
      // await syncStorage.isFavoriteSync.set(false);
    }
  }

  Future<List<Ad>> getProductFavoriteAds() async {
    try {
      final isLogin = tokenStorage.isUserLoggedIn;
      if (isLogin) {
        final response = await _favoriteService.getFavoriteAds();
        final allRemoteAds = AdRootResponse.fromJson(response.data)
            .data
            .results
            .map((item) => item.toMap(isFavorite: true));
        final allItem =
            favoriteStorage.allItems.map((item) => item.toMap()).toList();
        for (var item in allRemoteAds) {
          if (allItem.where((element) => element.id == item.id).isEmpty) {
            favoriteStorage.favoriteAds.add(item.toMap(isFavorite: true));
          }
        }
      }
      final result = favoriteStorage.allItems;
      return result
          .map((item) => item.toMap(isFavorite: true))
          .where((element) => (element.adTypeStatus == AdTransactionType.SELL ||
              element.adTypeStatus == AdTransactionType.FREE ||
              element.adTypeStatus == AdTransactionType.EXCHANGE ||
              element.adTypeStatus == AdTransactionType.BUY))
          .toList();
    } catch (e) {
      return List.empty();
    }
  }

  Future<List<Ad>> getServiceFavoriteAds() async {
    try {
      final isLogin = tokenStorage.isUserLoggedIn;
      if (isLogin) {
        final response = await _favoriteService.getFavoriteAds();
        final allRemoteAds = AdRootResponse.fromJson(response.data)
            .data
            .results
            .map((e) => e.toMap(isFavorite: true));
        final allItem = favoriteStorage.allItems.map((e) => e.toMap()).toList();
        for (var item in allRemoteAds) {
          if (allItem.where((element) => element.id == item.id).isEmpty) {
            favoriteStorage.favoriteAds.add(item.toMap(isFavorite: true));
          }
        }
      }
      final result = favoriteStorage.allItems;
      return result
          .map((e) => e.toMap(isFavorite: true))
          .where((element) =>
              (element.adTypeStatus == AdTransactionType.SERVICE ||
                  element.adTypeStatus == AdTransactionType.BUY_SERVICE))
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
      // await syncStorage.isFavoriteSync.set(true);
    } catch (e) {
      log.e(e.toString());
    }
  }
}

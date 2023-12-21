import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/data/responses/add_result/add_result_response.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';
import 'package:onlinebozor/domain/repositories/favorite_repository.dart';
import 'package:onlinebozor/domain/util.dart';

import '../../domain/models/ad.dart';
import '../responses/ad/ad/ad_response.dart';
import '../services/ad_service.dart';
import '../services/favorite_service.dart';
import '../storages/favorite_storage.dart';
import '../storages/sync_storage.dart';
import '../storages/token_storage.dart';

@LazySingleton(as: FavoriteRepository)
class FavoriteRepositoryImp extends FavoriteRepository {
  final FavoriteService _favoriteService;
  final TokenStorage tokenStorage;
  final FavoriteStorage favoriteStorage;
  final SyncStorage syncStorage;
  final AdsService adService;

  FavoriteRepositoryImp(
    this._favoriteService,
    this.tokenStorage,
    this.favoriteStorage,
    this.syncStorage,
    this.adService,
  );

  @override
  Future<int> addFavorite(Ad ad) async {
    final isLogin = tokenStorage.isLogin.call() ?? false;
    int resultId = ad.id;
    if (tokenStorage.isLogin.call() ?? false) {
      await adService.setViewAd(type: ViewType.selected, adId: ad.id);
    }
    if (isLogin) {
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

  @override
  Future<void> removeFavorite(Ad ad) async {
    favoriteStorage.removeFavorite(ad.id);
    final isLogin = tokenStorage.isLogin.call() ?? false;
    if (isLogin) {
      await _favoriteService.deleteFavorite(ad.id);
    } else {
      await syncStorage.isFavoriteSync.set(false);
    }
  }

  @override
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
          .where((element) => (element.adTypeStatus == AdTypeStatus.sell ||
              element.adTypeStatus == AdTypeStatus.free ||
              element.adTypeStatus == AdTypeStatus.exchange ||
              element.adTypeStatus == AdTypeStatus.buy))
          .toList();
    } catch (e) {
      return List.empty();
    }
  }

  @override
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
          .where((element) => (element.adTypeStatus == AdTypeStatus.service ||
              element.adTypeStatus == AdTypeStatus.buyService))
          .toList();
    } catch (e) {
      return List.empty();
    }
  }

  @override
  Future<void> pushAllFavoriteAds() async {
    final log = Logger();
    try {
      final allItem = favoriteStorage.allItems.map((e) => e.toMap()).toList();
      log.e(allItem.toString());
      await _favoriteService.sendAllFavoriteAds(allItem);
      await syncStorage.isFavoriteSync.set(true);
    } catch (e) {
      log.e(e.toString());}
  }
}

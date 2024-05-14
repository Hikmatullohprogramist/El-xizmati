import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/core/extensions/list_extensions.dart';
import 'package:onlinebozor/data/datasource/hive/storages/ad_storage.dart';
import 'package:onlinebozor/data/datasource/hive/storages/token_storage.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/ad/ad_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/add_result/add_result_response.dart';
import 'package:onlinebozor/data/datasource/network/services/favorite_service.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';

import '../../domain/models/ad/ad.dart';

@LazySingleton()
class FavoriteRepository {
  final AdStorage _adStorage;
  final FavoriteService _favoriteService;
  final TokenStorage _tokenStorage;

  FavoriteRepository(
    this._adStorage,
    this._favoriteService,
    this._tokenStorage,
  );

  Future<int> addToFavorite(Ad ad) async {
    final isLogin = _tokenStorage.isUserLoggedIn;
    int resultId = ad.id;
    if (isLogin) {
      final response = await _favoriteService.addToFavorite(adId: ad.id);
      final addResultId =
          AddResultRootResponse.fromJson(response.data).data?.products?.id;
      resultId = addResultId ?? ad.id;
    }
    _adStorage.addToFavorite(ad.toMap(backendId: resultId));
    return resultId;
  }

  Future<void> removeFromFavorite(int adId) async {
    final isLogin = _tokenStorage.isUserLoggedIn;
    if (isLogin) {
      await _favoriteService.removeFromFavorite(adId);
    }
    _adStorage.removeFromFavorite(adId);
  }

  Future<List<Ad>> getProductFavoriteAds() async {
    try {
      final isLogin = _tokenStorage.isUserLoggedIn;
      if (isLogin) {
        final response = await _favoriteService.getFavoriteAds();
        final responseAds = AdRootResponse.fromJson(response.data)
            .data
            .results
            .map((item) => item.toMap(isFavorite: true))
            .toList();

        final savedAds = _adStorage.favoriteAds.map((e) => e.toMap()).toList();
        final notSavedAds = responseAds.notContainsItems(savedAds);
        for (var item in notSavedAds) {
          _adStorage.addToFavorite(item.toMap());
        }
      }

      return _adStorage.favoriteAds
          .map((item) => item.toMap())
          .toList()
          .filterIf((e) => (e.isProductAd));
    } catch (e) {
      return List.empty();
    }
  }

  Future<List<Ad>> getServiceFavoriteAds() async {
    try {
      final isLogin = _tokenStorage.isUserLoggedIn;
      if (isLogin) {
        final response = await _favoriteService.getFavoriteAds();
        final responseAds = AdRootResponse.fromJson(response.data)
            .data
            .results
            .map((item) => item.toMap(isFavorite: true))
            .toList();

        final savedAds = _adStorage.favoriteAds.map((e) => e.toMap()).toList();
        final notSavedAds = responseAds.notContainsItems(savedAds);
        for (var item in notSavedAds) {
          _adStorage.addToFavorite(item.toMap());
        }
      }
      return _adStorage.favoriteAds
          .map((item) => item.toMap())
          .toList()
          .filterIf((e) => (e.isServiceAd));
    } catch (e) {
      return List.empty();
    }
  }

  Future<void> pushAllFavoriteAds() async {
    final logger = Logger();
    try {
      final favoriteAdIds = _adStorage.favoriteAds.map((e) => e.id).toList();
      logger.e(favoriteAdIds.toString());
      await _favoriteService.sendAllFavoriteAds(favoriteAdIds);
    } catch (e) {
      logger.e(e.toString());
    }
  }
}

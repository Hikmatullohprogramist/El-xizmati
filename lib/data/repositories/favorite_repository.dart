import 'package:logger/logger.dart';
import 'package:onlinebozor/core/extensions/list_extensions.dart';
import 'package:onlinebozor/data/datasource/floor/dao/ad_entity_dao.dart';
import 'package:onlinebozor/data/datasource/hive/storages/ad_storage.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/ad/ad_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/add_result/add_result_response.dart';
import 'package:onlinebozor/data/datasource/network/services/favorite_service.dart';
import 'package:onlinebozor/data/datasource/preference/token_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/user_preferences.dart';
import 'package:onlinebozor/data/error/app_locale_exception.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';
import 'package:onlinebozor/domain/models/ad/ad.dart';

// @LazySingleton()
class FavoriteRepository {
  final AdEntityDao _adEntityDao;
  final FavoriteService _favoriteService;
  final TokenPreferences _tokenPreferences;
  final UserPreferences _userPreferences;

  FavoriteRepository(
    this._adEntityDao,
    this._favoriteService,
    this._tokenPreferences,
    this._userPreferences,
  );

  Future<int> addToFavorite(Ad ad) async {
    final isLogin = _tokenPreferences.isAuthorized;
    int resultId = ad.id;
    if (isLogin) {
      final response = await _favoriteService.addToFavorite(adId: ad.id);
      final addResultId =
          AddResultRootResponse.fromJson(response.data).data?.products?.id;
      resultId = addResultId ?? ad.id;
    }

    await _adEntityDao.addToFavorite(ad.id);
    return resultId;
  }

  Future<void> removeFromFavorite(int adId) async {
    final isLogin = _tokenPreferences.isAuthorized;
    if (isLogin) {
      await _favoriteService.removeFromFavorite(adId);
    }

    await _adEntityDao.removeFromFavorite(adId);
  }

  Future<List<Ad>> getProductFavoriteAds() async {
    // if (_tokenPreferences.isNotAuthorized) throw NotAuthorizedException();
    // if (_userPreferences.isNotIdentified) throw NotIdentifiedException();

    final isLogin = _tokenPreferences.isAuthorized;
    if (isLogin) {
      final response = await _favoriteService.getFavoriteAds();
      final responseAds = AdRootResponse.fromJson(response.data)
          .data
          .results
          .map((item) => item.toAdEntity(isFavorite: true))
          .toList();
      await _adEntityDao.insertAds(responseAds);
    }

    final entities = await _adEntityDao.getFavoriteAds();
    return entities
        .map((e) => e.toAd())
        .toList()
        .filterIf((e) => (e.isProductAd));
  }

  Future<List<Ad>> getServiceFavoriteAds() async {
    // if (_tokenPreferences.isNotAuthorized) throw NotAuthorizedException();
    // if (_userPreferences.isNotIdentified) throw NotIdentifiedException();

    final isLogin = _tokenPreferences.isAuthorized;
    if (isLogin) {
      final response = await _favoriteService.getFavoriteAds();
      final responseAds = AdRootResponse.fromJson(response.data)
          .data
          .results
          .map((item) => item.toAdEntity(isFavorite: true))
          .toList();
      await _adEntityDao.insertAds(responseAds);
    }
    final entities = await _adEntityDao.getFavoriteAds();
    return entities
        .map((e) => e.toAd())
        .toList()
        .filterIf((e) => (e.isProductAd));
  }

  Future<void> pushAllFavoriteAds() async {
    final logger = Logger();
    try {
      final favoriteAds = await _adEntityDao.getFavoriteAds();
      final favoriteAdIds = favoriteAds.map((e) => e.id).toList();
      logger.e(favoriteAdIds.toString());
      await _favoriteService.sendAllFavoriteAds(favoriteAdIds);
    } catch (e) {
      logger.e(e.toString());
    }
  }
}

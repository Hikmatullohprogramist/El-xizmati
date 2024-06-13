import 'package:onlinebozor/data/datasource/floor/dao/ad_entity_dao.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/ad/ad_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/ad_detail/ad_detail_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/search/search_response.dart';
import 'package:onlinebozor/data/datasource/network/services/ad_service.dart';
import 'package:onlinebozor/data/datasource/preference/auth_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/user_preferences.dart';
import 'package:onlinebozor/data/error/app_locale_exception.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';
import 'package:onlinebozor/domain/models/ad/ad.dart';
import 'package:onlinebozor/domain/models/ad/ad_detail.dart';
import 'package:onlinebozor/domain/models/ad/ad_type.dart';
import 'package:onlinebozor/domain/models/stats/stats_type.dart';

class AdRepository {
  final AdEntityDao _adEntityDao;
  final AdService _adsService;
  final AuthPreferences _authPreferences;
  final UserPreferences _userPreferences;

  AdRepository(
    this._adEntityDao,
    this._adsService,
    this._authPreferences,
    this._userPreferences,
  );

  Future<List<Ad>> _getAsCombined(List<AdResponse> ads) async {
    await _adEntityDao.upsertAds(ads.map((e) => e.toAdEntity()).toList());
    final ids = ads.map((e) => e.id).toList();
    final entities = await _adEntityDao.readAdsByIds(ids);
    return entities.map((e) => e.toAd()).toList(growable: true);
  }

  Stream<List<Ad>> watchAdsByIds(List<int> adIds) {
    return _adEntityDao
        .watchAdsByIds(adIds)
        .asyncMap((event) => event.map((e) => e.toAd()).toList());
  }

  Future<List<Ad>> getHomeAds(
    int pageIndex,
    int pageSize,
    String keyWord,
  ) async {
    final response = await _adsService.getHomeAds(pageIndex, pageSize, keyWord);
    final adResponses = AdRootResponse.fromJson(response.data).data.results;

    return _getAsCombined(adResponses);
  }

  Future<List<Ad>> getDashboardPopularAds({required AdType adType}) async {
    final response = await _adsService.getDashboardAdsByType(adType: adType);
    final adResponses = AdRootResponse.fromJson(response.data).data.results;

    return _getAsCombined(adResponses);
  }

  Future<List<Ad>> getDashboardTopRatedAds() async {
    final response = await _adsService.getDashboardTopRatedAds();
    final adResponses = AdRootResponse.fromJson(response.data).data.results;

    return _getAsCombined(adResponses);
  }

  Future<List<Ad>> getPopularAdsByType({
    required AdType adType,
    required int page,
    required int limit,
  }) async {
    final response = await _adsService.getPopularAdsByType(
      adType: adType,
      page: page,
      limit: limit,
    );
    final adResponses = AdRootResponse.fromJson(response.data).data.results;

    return _getAsCombined(adResponses);
  }

  Future<List<Ad>> getCheapAdsByType({
    required AdType adType,
    required int page,
    required int limit,
  }) async {
    final response = await _adsService.getCheapAdsByAdType(
      adType: adType,
      page: page,
      limit: limit,
    );
    final adResponses = AdRootResponse.fromJson(response.data).data.results;

    return _getAsCombined(adResponses);
  }

  Future<List<Ad>> getAdsByType({
    required int page,
    required int limit,
    required AdType adType,
  }) async {
    Future.delayed(Duration(seconds: 3));
    throw UnsupportedError("test");

    final response = await _adsService.getAdsByAdType(adType, page, limit);
    final adResponses = AdRootResponse.fromJson(response.data).data.results;
    return _getAsCombined(adResponses);
  }

  Future<AdDetail?> getAdDetail(int adId) async {
    final savedAd = await _adEntityDao.readAdById(adId);
    final response = await _adsService.getAdDetail(adId);
    final adDetail = AdDetailRootResponse.fromJson(response.data).data.results;

    return adDetail.toMap(
      isInCart: savedAd?.isInCart ?? false,
      isFavorite: savedAd?.isFavorite ?? false,
    );
  }

  Future<List<AdSearchResponse>> getSearch(String query) async {
    final response = await _adsService.getSearchAd(query);
    final searchAd = SearchResponse.fromJson(response.data).data;
    return searchAd.ads;
  }

  Future<List<Ad>> getAdsByUser({
    required int sellerTin,
    required int page,
    required int limit,
  }) async {
    if (_authPreferences.isNotAuthorized) throw NotAuthorizedException();
    if (_userPreferences.isNotIdentified) throw NotIdentifiedException();

    final response = await _adsService.getAdsByUser(
      sellerTin: sellerTin,
      page: page,
      limit: limit,
    );
    final adResponses = AdRootResponse.fromJson(response.data).data.results;
    return _getAsCombined(adResponses);
  }

  Future<List<Ad>> getSimilarAds({
    required int adId,
    required int page,
    required int limit,
  }) async {
    final response =
        await _adsService.getSimilarAds(adId: adId, page: page, limit: limit);
    final adResponses = AdRootResponse.fromJson(response.data).data.results;
    return _getAsCombined(adResponses);
  }

  Future<void> increaseAdStats({
    required StatsType type,
    required int adId,
  }) async {
    await _adsService.increaseAdStats(type: type, adId: adId);
    return;
  }

  Future<void> addAdToRecentlyViewed({required int adId}) async {
    if (_authPreferences.isNotAuthorized) throw NotAuthorizedException();

    await _adsService.addAdToRecentlyViewed(adId: adId);
    return;
  }

  Future<List<Ad>> getRecentlyViewedAds({
    required int page,
    required int limit,
  }) async {
    if (_authPreferences.isNotAuthorized) throw NotAuthorizedException();

    final response = await _adsService.getRecentlyViewedAds(
      page: page,
      limit: limit,
    );
    final adResponses = AdRootResponse.fromJson(response.data).data.results;
    return _getAsCombined(adResponses);
  }
}

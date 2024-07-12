import 'package:logger/logger.dart';
import 'package:onlinebozor/core/extensions/list_extensions.dart';
import 'package:onlinebozor/data/datasource/floor/dao/ad_entity_dao.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/ad/ad_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/ad_detail/ad_detail_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/search/search_response.dart';
import 'package:onlinebozor/data/datasource/network/services/private/ad_service.dart';
import 'package:onlinebozor/data/datasource/network/services/public/ad_detail_service.dart';
import 'package:onlinebozor/data/datasource/network/services/public/ad_list_service.dart';
import 'package:onlinebozor/data/datasource/network/services/public/dashboard_service.dart';
import 'package:onlinebozor/data/datasource/preference/auth_preferences.dart';
import 'package:onlinebozor/data/error/app_locale_exception.dart';
import 'package:onlinebozor/data/mappers/ad_mappers.dart';
import 'package:onlinebozor/domain/models/ad/ad.dart';
import 'package:onlinebozor/domain/models/ad/ad_detail.dart';
import 'package:onlinebozor/domain/models/ad/ad_type.dart';
import 'package:onlinebozor/domain/models/stats/stats_type.dart';

class AdRepository {
  final AdDetailService _adDetailService;
  final AdEntityDao _adEntityDao;
  final AdListService _adListService;
  final AdService _adService;
  final AuthPreferences _authPreferences;
  final DashboardService _dashboardService;

  AdRepository(
    this._adDetailService,
    this._adEntityDao,
    this._adListService,
    this._adService,
    this._authPreferences,
    this._dashboardService,
  );

  Future<List<Ad>> _readAdsBySaving(List<AdResponse> ads) async {
    await _adEntityDao.upsertAds(ads.map((e) => e.toAdEntity()).toList());
    final ids = ads.map((e) => e.id).toList();
    Logger().w("_getAsCombined ids = $ids");
    final entities = await _adEntityDao.readAdsByIds(ids);
    return entities.map((e) => e.toAd()).toList(growable: true)..sortByIds(ids);
  }

  Stream<List<Ad>> watchAdsByIds(List<int> adIds) {
    return _adEntityDao.watchAdsByIds(adIds).asyncMap((event) {
      return event.map((e) => e.toAd()).toList()..sortByIds(adIds);
    });
  }

  Future<List<Ad>> getAdsByCategory(int page, int limit, String key) async {
    final response = await _adListService.getAdsByCategory(page, limit, key);
    final adResponses = AdRootResponse.fromJson(response.data).data.results;

    return _readAdsBySaving(adResponses);
  }

  Future<List<Ad>> getDashboardPopularAds({required AdType adType}) async {
    final response = await _adListService.getDashboardAdsByType(adType: adType);
    final adResponses = AdRootResponse.fromJson(response.data).data.results;

    return _readAdsBySaving(adResponses);
  }

  Future<List<Ad>> getDashboardTopRatedAds() async {
    final response = await _dashboardService.getDashboardTopRatedAds();
    final adResponses = AdRootResponse.fromJson(response.data).data.results;

    return _readAdsBySaving(adResponses);
  }

  Future<List<Ad>> getPopularAdsByType({
    required AdType adType,
    required int page,
    required int limit,
  }) async {
    final response = await _adListService.getPopularAdsByType(
      adType: adType,
      page: page,
      limit: limit,
    );
    final adResponses = AdRootResponse.fromJson(response.data).data.results;

    return _readAdsBySaving(adResponses);
  }

  Future<List<Ad>> getCheapAdsByType({
    required AdType adType,
    required int page,
    required int limit,
  }) async {
    final response = await _adListService.getCheapAdsByAdType(
      adType: adType,
      page: page,
      limit: limit,
    );
    final adResponses = AdRootResponse.fromJson(response.data).data.results;

    return _readAdsBySaving(adResponses);
  }

  Future<List<Ad>> getAdsByType({
    required int page,
    required int limit,
    required AdType adType,
  }) async {
    final response = await _adListService.getAdsByAdType(adType, page, limit);
    final adResponses = AdRootResponse.fromJson(response.data).data.results;
    return _readAdsBySaving(adResponses);
  }

  Future<AdDetail?> getAdDetail(int adId) async {
    final savedAd = await _adEntityDao.readAdById(adId);
    final response = await _adDetailService.getAdDetail(adId);
    final adDetail = AdDetailRootResponse.fromJson(response.data).data.results;

    return adDetail.toMap(
      isInCart: savedAd?.isInCart ?? false,
      isFavorite: savedAd?.isFavorite ?? false,
    );
  }

  Future<List<AdSearchResponse>> getSearch(String query) async {
    final response = await _adListService.getSearchAd(query);
    final searchAd = SearchResponse.fromJson(response.data).data;
    return searchAd.ads;
  }

  Future<List<Ad>> getAdsByUser({
    required int sellerTin,
    required int page,
    required int limit,
  }) async {
    final response = await _adListService.getAdsByUser(
      sellerTin: sellerTin,
      page: page,
      limit: limit,
    );
    final adResponses = AdRootResponse.fromJson(response.data).data.results;
    return _readAdsBySaving(adResponses);
  }

  Future<List<Ad>> getSimilarAds({
    required int adId,
    required int page,
    required int limit,
  }) async {
    final response = await _adDetailService.getSimilarAds(
        adId: adId, page: page, limit: limit);
    final adResponses = AdRootResponse.fromJson(response.data).data.results;
    return _readAdsBySaving(adResponses);
  }

  Future<void> increaseAdStats({
    required StatsType type,
    required int adId,
  }) async {
    await _adDetailService.increaseAdStats(type: type, adId: adId);
    return;
  }

  Future<void> addAdToRecentlyViewed({required int adId}) async {
    if (_authPreferences.isNotAuthorized) throw NotAuthorizedException();

    await _adService.addAdToRecentlyViewed(adId: adId);
    return;
  }

  Future<List<Ad>> getRecentlyViewedAds({
    required int page,
    required int limit,
  }) async {
    if (_authPreferences.isNotAuthorized) throw NotAuthorizedException();

    final response = await _adService.getRecentlyViewedAds(
      page: page,
      limit: limit,
    );
    final adResponses = AdRootResponse.fromJson(response.data).data.results;
    return _readAdsBySaving(adResponses);
  }
}

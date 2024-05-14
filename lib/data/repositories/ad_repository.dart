import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/extensions/list_extensions.dart';
import 'package:onlinebozor/data/datasource/hive/storages/ad_storage.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/ad/ad_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/ad_detail/ad_detail_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/search/search_response.dart';
import 'package:onlinebozor/data/datasource/network/services/ad_service.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';

import '../../domain/models/ad/ad.dart';
import '../../domain/models/ad/ad_detail.dart';
import '../../domain/models/ad/ad_type.dart';
import '../../domain/models/stats/stats_type.dart';

@LazySingleton()
class AdRepository {
  final AdsService _adsService;
  final AdStorage _adStorage;

  AdRepository(this._adsService, this._adStorage);

  List<Ad> _getAsCombined(List<AdResponse> ads) {
    final savedAds = _adStorage.allAds;
    return ads.map((ad) {
      final savedAd = savedAds.firstIf((e) => e.id == ad.id);
      return ad.toMap(
        isFavorite: savedAd?.isFavorite ?? false,
        isAddedToCart: savedAd?.isAddedToCart ?? false,
      );
    }).toList(growable: true);
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
    final response = await _adsService.getAdsByAdType(adType, page, limit);
    final adResponses = AdRootResponse.fromJson(response.data).data.results;
    return _getAsCombined(adResponses);
  }

  Future<AdDetail?> getAdDetail(int adId) async {
    final savedAd = _adStorage.allAds.firstIf((e) => e.id == adId);
    final response = await _adsService.getAdDetail(adId);
    final adDetail = AdDetailRootResponse.fromJson(response.data).data.results;
    return adDetail.toMap(
      favorite: savedAd?.isFavorite ?? false,
      isAddCart: savedAd?.isFavorite ?? false,
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
    await _adsService.addAdToRecentlyViewed(adId: adId);
    return;
  }

  Future<List<Ad>> getRecentlyViewedAds({
    required int page,
    required int limit,
  }) async {
    final response =
        await _adsService.getRecentlyViewedAds(page: page, limit: limit);
    final adResponses = AdRootResponse.fromJson(response.data).data.results;
    return _getAsCombined(adResponses);
  }
}

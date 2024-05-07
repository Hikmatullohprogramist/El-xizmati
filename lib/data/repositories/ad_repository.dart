import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/hive/storages/favorite_storage.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/ad/ad_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/ad_detail/ad_detail_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/search/search_response.dart';
import 'package:onlinebozor/data/datasource/network/services/ad_service.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';

import '../../domain/models/ad/ad.dart';
import '../../domain/models/ad/ad_detail.dart';
import '../../domain/models/ad/ad_type.dart';
import '../../domain/models/stats/stats_type.dart';
import '../datasource/hive/storages/cart_storage.dart';

@LazySingleton()
class AdRepository {
  final AdsService _adsService;
  final CartStorage cartStorage;
  final FavoriteStorage favoriteStorage;

  AdRepository(this._adsService, this.favoriteStorage, this.cartStorage);

  Future<List<Ad>> getHomeAds(
      int pageIndex, int pageSize, String keyWord) async {
    final allItems = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    final response = await _adsService.getHomeAds(pageIndex, pageSize, keyWord);
    final adsResponse = AdRootResponse.fromJson(response.data).data.results;
    final ads = adsResponse
        .map(
          (ad) => ad.toMap(
              isFavorite:
                  allItems.where((element) => element.id == ad.id).isNotEmpty),
        )
        .toList(growable: true);
    return ads;
  }

  Future<List<Ad>> getDashboardPopularAdsByType({
    required AdType adType,
  }) async {
    final allItems = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    final response = await _adsService.getDashboardAdsByType(adType: adType);
    final adsResponse = AdRootResponse.fromJson(response.data).data.results;
    final ads = adsResponse
        .map(
          (ad) => ad.toMap(
              isFavorite:
                  allItems.where((element) => element.id == ad.id).isNotEmpty),
        )
        .toList(growable: true);
    return ads;
  }

  Future<List<Ad>> getDashboardTopRatedAds() async {
    final allItems = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    final response = await _adsService.getDashboardTopRatedAds();
    final adsResponse = AdRootResponse.fromJson(response.data).data.results;
    final ads = adsResponse
        .map(
          (ad) => ad.toMap(
              isFavorite:
                  allItems.where((element) => element.id == ad.id).isNotEmpty),
        )
        .toList(growable: true);
    return ads;
  }

  Future<List<Ad>> getPopularAdsByType({
    required AdType adType,
    required int page,
    required int limit,
  }) async {
    final allItems = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    final response = await _adsService.getPopularAdsByType(
      adType: adType,
      page: page,
      limit: limit,
    );
    final adsResponse = AdRootResponse.fromJson(response.data).data.results;
    final ads = adsResponse
        .map(
          (ad) => ad.toMap(
              isFavorite:
                  allItems.where((element) => element.id == ad.id).isNotEmpty),
        )
        .toList(growable: true);
    return ads;
  }

  Future<List<Ad>> getCheapAdsByType(
      {required AdType adType, required int page, required int limit}) async {
    final allItems = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    final response = await _adsService.getCheapAdsByAdType(
        adType: adType, page: page, limit: limit);
    final adsResponse = AdRootResponse.fromJson(response.data).data.results;
    final ads = adsResponse
        .map(
          (ad) => ad.toMap(
              isFavorite:
                  allItems.where((element) => element.id == ad.id).isNotEmpty),
        )
        .toList(growable: true);
    return ads;
  }

  Future<List<Ad>> getHotDiscountAdsByType(
      AdType collectiveType, int pageIndex, int pageSize) async {
    final allItems = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    final response = await _adsService.getHomePopularAds(pageIndex, pageSize);
    final adsResponse = AdRootResponse.fromJson(response.data).data.results;
    final ads = adsResponse
        .map(
          (ad) => ad.toMap(
              isFavorite:
                  allItems.where((element) => element.id == ad.id).isNotEmpty),
        )
        .toList(growable: true);
    return ads;
  }

  Future<List<Ad>> getAdsByType(
      {required int page, required int limit, required AdType adType}) async {
    final allItems = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    final response = await _adsService.getAdsByAdType(adType, page, limit);
    final adsResponse = AdRootResponse.fromJson(response.data).data.results;
    final ads = adsResponse
        .map(
          (ad) => ad.toMap(
              isFavorite:
                  allItems.where((element) => element.id == ad.id).isNotEmpty),
        )
        .toList(growable: true);
    return ads;
  }

  Future<AdDetail?> getAdDetail(int adId) async {
    final allItems =
        favoriteStorage.allItems.map((item) => item.toMap()).toList();
    final allCartItems =
        cartStorage.allItems.map((item) => item.toMap()).toList();
    final response = await _adsService.getAdDetail(adId);
    final adDetailResponse =
        AdDetailRootResponse.fromJson(response.data).data.results;
    final adDetail = adDetailResponse.toMap(
        favorite: allItems.where((element) => element.id == adId).isNotEmpty,
        isAddCart:
            allCartItems.where((element) => element.id == adId).isNotEmpty);
    return adDetail;
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
    final allItems = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    final response = await _adsService.getAdsByUser(
      sellerTin: sellerTin,
      page: page,
      limit: limit,
    );
    final adsResponse = AdRootResponse.fromJson(response.data).data.results;
    final ads = adsResponse
        .map(
          (ad) => ad.toMap(
              isFavorite:
                  allItems.where((element) => element.id == ad.id).isNotEmpty),
        )
        .toList(growable: true);
    return ads;
  }

  Future<List<Ad>> getSimilarAds({
    required int adId,
    required int page,
    required int limit,
  }) async {
    final allItems = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    final response =
        await _adsService.getSimilarAds(adId: adId, page: page, limit: limit);
    final adsResponse = AdRootResponse.fromJson(response.data).data.results;
    final ads = adsResponse
        .map(
          (ad) => ad.toMap(
              isFavorite:
                  allItems.where((element) => element.id == ad.id).isNotEmpty),
        )
        .toList(growable: true);
    return ads;
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
    final allItems = favoriteStorage.allItems.map((ad) => ad.toMap()).toList();
    final response =
        await _adsService.getRecentlyViewedAds(page: page, limit: limit);
    final adsResponse = AdRootResponse.fromJson(response.data).data.results;
    final ads = adsResponse
        .map(
          (ad) => ad.toMap(
              isFavorite:
                  allItems.where((element) => element.id == ad.id).isNotEmpty),
        )
        .toList(growable: true);
    return ads;
  }
}

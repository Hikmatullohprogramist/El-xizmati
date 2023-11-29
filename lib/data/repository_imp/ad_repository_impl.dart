import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/model/search/search_response.dart';
import 'package:onlinebozor/domain/mapper/ad_mapper.dart';
import 'package:onlinebozor/presentation/ad/ad_collection/cubit/ad_collection_cubit.dart';

import '../../domain/model/ad_detail.dart';
import '../../domain/model/ad.dart';
import '../../domain/repository/ad_repository.dart';
import '../api/ad_api.dart';
import '../model/ads/ad/ad_response.dart';
import '../model/ads/ad_detail/ad_detail_response.dart';
import '../storage/favorite_storage.dart';

@LazySingleton(as: AdRepository)
class AdRepositoryImpl extends AdRepository {
  final AdsApi _api;
  final FavoriteStorage favoriteStorage;

  AdRepositoryImpl(this._api, this.favoriteStorage);

  @override
  Future<List<Ad>> getHomeAds(
      int pageIndex, int pageSize, String keyWord) async {
    final allItems = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    final response = await _api.getHomeAds(pageIndex, pageSize, keyWord);
    final adsResponse =
        AdRootResponse.fromJson(response.data).data?.results ?? List.empty();
    final result = adsResponse
        .map((item) => item.toMap(
            favorite:
                allItems.where((element) => element.id == item.id).isNotEmpty))
        .toList(growable: true);
    return result;
  }

  @override
  Future<List<Ad>> getRecentlyViewAds() async {
    final allItems = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    final response = await _api.getHomePopularAds();
    final adsResponse =
        AdRootResponse.fromJson(response.data).data?.results ?? List.empty();
    final result = adsResponse
        .map((item) => item.toMap(
            favorite:
                allItems.where((element) => element.id == item.id).isNotEmpty))
        .toList(growable: true);
    return result;
  }

  @override
  Future<AdDetail?> getAdDetail(int adId) async {
    final allItems = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    final response = await _api.getAdDetail(adId);
    final adDetail = AdDetailRootResponse.fromJson(response.data).data.results;
    final result = adDetail.toMap(favorite:
    allItems.where((element) => element.id == adId).isNotEmpty);
    return result;
  }

  @override
  Future<List<Ad>> getAdModels(
      int pageIndex, int pageSize, String keyWord) async {
    final response = await _api.getHomeAds(pageIndex, pageSize, keyWord);
    final adsResponse =
        AdRootResponse.fromJson(response.data).data?.results ?? List.empty();
    final result = adsResponse.map((e) => e.toMap()).toList(growable: true);
    return result;
  }

  @override
  Future<List<Ad>> getHotDiscountAds(CollectiveType collectiveType) async {
    final allItems = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    final response = await _api.getHomePopularAds();
    final adsResponse =
        AdRootResponse.fromJson(response.data).data?.results ?? List.empty();
    final result = adsResponse
        .map((item) => item.toMap(
            favorite:
                allItems.where((element) => element.id == item.id).isNotEmpty))
        .toList(growable: true);
    return result;
  }

  @override
  Future<List<Ad>> getPopularAds(CollectiveType collectiveType) async {
    final allItems = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    final response = await _api.getHomePopularAds();
    final adsResponse =
        AdRootResponse.fromJson(response.data).data?.results ?? List.empty();
    final result = adsResponse
        .map((item) => item.toMap(
        favorite:
        allItems.where((element) => element.id == item.id).isNotEmpty))
        .toList(growable: true);
    return result;
  }

  @override
  Future<List<Ad>> getCollectiveAds(int pageIndex, int pageSize,
      String keyWord, CollectiveType collectiveType) async {
    final allItems = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    final response = await _api.getCollectiveAds(
        collectiveType, pageIndex, pageSize, keyWord);
    final adsResponse =
        AdRootResponse.fromJson(response.data).data?.results ?? List.empty();
    final result = adsResponse
        .map((item) => item.toMap(
        favorite:
        allItems.where((element) => element.id == item.id).isNotEmpty))
        .toList(growable: true);
    return result;
  }

  @override
  Future<List<AdSearchResponse>> getSearch(String query) async {
    final response = await _api.getSearchAd(query);
    final searchAd = SearchResponse.fromJson(response.data).data;
    return searchAd?.ads ?? List.empty();
  }
}

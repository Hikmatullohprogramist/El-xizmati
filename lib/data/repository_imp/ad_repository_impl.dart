import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/model/search/search_response.dart';
import 'package:onlinebozor/domain/mapper/ad_mapper.dart';
import 'package:onlinebozor/presentation/ad/ad_collection/cubit/ad_collection_cubit.dart';

import '../../domain/model/ad_detail.dart';
import '../../domain/model/ad_model.dart';
import '../../domain/repository/ad_repository.dart';
import '../api/ads_api.dart';
import '../model/ads/ad/ad_response.dart';
import '../model/ads/ad_detail/ad_detail_response.dart';
import '../storage/storage.dart';

@LazySingleton(as: AdRepository)
class AdRepositoryImpl extends AdRepository {
  final AdsApi _api;
  final Storage _storage;

  AdRepositoryImpl(this._api, this._storage);

  @override
  Future<List<AdModel>> getHomeAds(
      int pageIndex, int pageSize, String keyWord) async {
    final response = await _api.getHomeAds(pageIndex, pageSize, keyWord);
    final adsResponse =
        AdRootResponse.fromJson(response.data).data?.results ?? List.empty();
    final result = adsResponse.map((e) => e.toMap()).toList(growable: true);
    return result;
  }

  @override
  Future<List<AdModel>> getRecentlyViewAds() async {
    final response = await _api.getHomePopularAds();
    final adsResponse =
        AdRootResponse.fromJson(response.data).data?.results ?? List.empty();
    final result = adsResponse.map((e) => e.toMap()).toList(growable: true);
    return result;
  }

  @override
  Future<AdDetail?> getAdDetail(int adId) async {
    final response = await _api.getAdDetail(adId);
    final adDetail = AdDetailRootResponse.fromJson(response.data).data.results;
    final result = adDetail.toMap();
    return result;
  }

  @override
  Future<List<AdModel>> getAdModels(
      int pageIndex, int pageSize, String keyWord) async {
    final response = await _api.getHomeAds(pageIndex, pageSize, keyWord);
    final adsResponse =
        AdRootResponse.fromJson(response.data).data?.results ?? List.empty();
    final result = adsResponse.map((e) => e.toMap()).toList(growable: true);
    return result;
  }

  @override
  Future<List<AdModel>> getHotDiscountAds(CollectiveType collectiveType) async {
    final response = await _api.getHomePopularAds();
    final adsResponse =
        AdRootResponse.fromJson(response.data).data?.results ?? List.empty();
    final result = adsResponse.map((e) => e.toMap()).toList(growable: true);
    return result;
  }

  @override
  Future<List<AdModel>> getPopularAds(CollectiveType collectiveType) async {
    final response = await _api.getHomePopularAds();
    final adsResponse =
        AdRootResponse.fromJson(response.data).data?.results ?? List.empty();
    final result = adsResponse.map((e) => e.toMap()).toList(growable: true);
    return result;
  }

  @override
  Future<List<AdModel>> getCollectiveAds(int pageIndex, int pageSize,
      String keyWord, CollectiveType collectiveType) async {
    final response = await _api.getCollectiveAds(
        collectiveType, pageIndex, pageSize, keyWord);
    final adsResponse =
        AdRootResponse.fromJson(response.data).data?.results ?? List.empty();
    final result = adsResponse.map((e) => e.toMap()).toList(growable: true);
    return result;
  }

  @override
  Future<List<AdSearchResponse>> getSearch(String query) async {
    final response = await _api.getSearchAd(query);
    final searchAd = SearchResponse.fromJson(response.data).data;
    return searchAd?.ads ?? List.empty();
  }
}

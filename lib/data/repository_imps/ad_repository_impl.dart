import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/mappers/ad_mapper.dart';

import '../../domain/models/ad.dart';
import '../../domain/models/ad_detail.dart';
import '../../domain/repositories/ad_repository.dart';
import '../../presentation/ad/ad_collection/cubit/ad_collection_cubit.dart';
import '../responses/ad/ad/ad_response.dart';
import '../responses/ad/ad_detail/ad_detail_response.dart';
import '../responses/search/search_response.dart';
import '../services/ad_service.dart';
import '../storages/favorite_storage.dart';

@LazySingleton(as: AdRepository)
class AdRepositoryImpl extends AdRepository {
  final AdsService _adsService;
  final FavoriteStorage favoriteStorage;

  AdRepositoryImpl(this._adsService, this.favoriteStorage);

  @override
  Future<List<Ad>> getHomeAds(
      int pageIndex, int pageSize, String keyWord) async {
    final allItems = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    final response = await _adsService.getHomeAds(pageIndex, pageSize, keyWord);
    final adsResponse = AdRootResponse.fromJson(response.data).data.results;
    final ads = adsResponse
        .map((ad) => ad.toMap(
            favorite:
                allItems.where((element) => element.id == ad.id).isNotEmpty))
        .toList(growable: true);
    return ads;
  }

  @override
  Future<List<Ad>> getRecentlyViewAds() async {
    final allItems = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    final response = await _adsService.getHomePopularAds();
    final adsResponse = AdRootResponse.fromJson(response.data).data.results;
    final ads = adsResponse
        .map((ad) => ad.toMap(
            favorite:
                allItems.where((element) => element.id == ad.id).isNotEmpty))
        .toList(growable: true);
    return ads;
  }

  @override
  Future<List<Ad>> getCollectivePopularAds(CollectiveType collectiveType) async {
    final allItems = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    final response = await _adsService.getHomePopularAds();
    final adsResponse = AdRootResponse.fromJson(response.data).data.results;
    final ads = adsResponse
        .map((ad) => ad.toMap(
            favorite:
                allItems.where((element) => element.id == ad.id).isNotEmpty))
        .toList(growable: true);
    return ads;
  }

  @override
  Future<List<Ad>> getCollectiveRecentlyAds(
      CollectiveType collectiveType) async {
    final allItems = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    final response = await _adsService.getCollectiveRecentlyAds(collectiveType);
    final adsResponse = AdRootResponse.fromJson(response.data).data.results;
    final ads = adsResponse
        .map((ad) => ad.toMap(
            favorite:
                allItems.where((element) => element.id == ad.id).isNotEmpty))
        .toList(growable: true);
    return ads;
  }

  @override
  Future<AdDetail?> getAdDetail(int adId) async {
    final allItems = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    final response = await _adsService.getAdDetail(adId);
    final adDetailResponse =
        AdDetailRootResponse.fromJson(response.data).data.results;
    final adDetail = adDetailResponse.toMap(
        favorite: allItems.where((element) => element.id == adId).isNotEmpty);
    return adDetail;
  }

  @override
  Future<List<Ad>> getHotDiscountAds(CollectiveType collectiveType) async {
    final allItems = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    final response = await _adsService.getHomePopularAds();
    final adsResponse = AdRootResponse.fromJson(response.data).data.results;
    final ads = adsResponse
        .map((ad) => ad.toMap(
            favorite:
                allItems.where((element) => element.id == ad.id).isNotEmpty))
        .toList(growable: true);
    return ads;
  }

  @override
  Future<List<Ad>> getCollectiveAds(int pageIndex, int pageSize,
      String keyWord, CollectiveType collectiveType) async {
    final allItems = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    final response = await _adsService.getCollectiveAds(
        collectiveType, pageIndex, pageSize, keyWord);
    final adsResponse = AdRootResponse.fromJson(response.data).data.results;
    final ads = adsResponse
        .map((ad) => ad.toMap(
            favorite:
                allItems.where((element) => element.id == ad.id).isNotEmpty))
        .toList(growable: true);
    return ads;
  }

  @override
  Future<List<AdSearchResponse>> getSearch(String query) async {
    final response = await _adsService.getSearchAd(query);
    final searchAd = SearchResponse.fromJson(response.data).data;
    return searchAd.ads;
  }

  @override
  Future<List<Ad>> getSellerAds(int sellerTin) async {
    final allItems = favoriteStorage.allItems.map((e) => e.toMap()).toList();
    final response = await _adsService.getSellerAds(sellerTin);
    final adsResponse = AdRootResponse.fromJson(response.data).data.results;
    final ads = adsResponse
        .map((ad) => ad.toMap(
            favorite:
                allItems.where((element) => element.id == ad.id).isNotEmpty))
        .toList(growable: true);
    return ads;
  }
}

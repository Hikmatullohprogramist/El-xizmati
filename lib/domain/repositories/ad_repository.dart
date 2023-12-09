import 'package:onlinebozor/presentation/ad/ad_collection/cubit/ad_collection_cubit.dart';

import '../../data/responses/search/search_response.dart';
import '../models/ad.dart';
import '../models/ad_detail.dart';

abstract class AdRepository {
  Future<List<Ad>> getHomeAds(int pageIndex, int pageSize, String keyWord);

  Future<List<Ad>> getRecentlyViewAds();

  Future<List<Ad>> getCollectivePopularAds(CollectiveType collectiveType);

  Future<AdDetail?> getAdDetail(int adId);

  Future<List<Ad>> getCollectiveRecentlyAds(CollectiveType collectiveType);

  Future<List<Ad>> getCollectiveAds(int pageIndex, int pageSize, String keyWord,
      CollectiveType collectiveType);

  Future<List<Ad>> getHotDiscountAds(CollectiveType collectiveType);

  Future<List<AdSearchResponse>> getSearch(String query);

  Future<List<Ad>> getSellerAds(int sellerTin);

  Future<List<Ad>> getSimilarAds(int adId);
}

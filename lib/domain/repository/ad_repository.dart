import 'package:onlinebozor/data/model/search/search_response.dart';
import 'package:onlinebozor/domain/model/ad_detail.dart';
import 'package:onlinebozor/presentation/ad/ad_collection/cubit/ad_collection_cubit.dart';

import '../model/ad.dart';

abstract class AdRepository {
  Future<List<Ad>> getHomeAds(int pageIndex, int pageSize, String keyWord);

  Future<List<Ad>> getRecentlyViewAds();

  Future<List<Ad>> getPopularAds(CollectiveType collectiveType);

  Future<AdDetail?> getAdDetail(int adId);

  Future<List<Ad>> getCollectiveAds(int pageIndex, int pageSize,
      String keyWord, CollectiveType collectiveType);

  Future<List<Ad>> getHotDiscountAds(CollectiveType collectiveType);

  Future<List<AdSearchResponse>> getSearch(String query);
}

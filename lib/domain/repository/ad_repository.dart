import 'package:onlinebozor/data/model/search/search_response.dart';
import 'package:onlinebozor/domain/model/ad_detail.dart';
import 'package:onlinebozor/presentation/ad/ad_collection/cubit/ad_collection_cubit.dart';

import '../model/ad_model.dart';

abstract class AdRepository {
  Future<List<AdModel>> getHomeAds(int pageIndex, int pageSize, String keyWord);

  Future<List<AdModel>> getRecentlyViewAds();

  Future<List<AdModel>> getPopularAds(CollectiveType collectiveType);

  Future<AdDetail?> getAdDetail(int adId);

  Future<List<AdModel>> getCollectiveAds(int pageIndex, int pageSize,
      String keyWord, CollectiveType collectiveType);

  Future<List<AdModel>> getHotDiscountAds(CollectiveType collectiveType);

  Future<List<AdSearchResponse>> getSearch(String query);
}

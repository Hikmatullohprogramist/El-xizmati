import 'package:onlinebozor/presentation/ad/ad_collection/cubit/ad_collection_cubit.dart';

import '../../data/responses/search/search_response.dart';
import '../models/ad.dart';
import '../models/ad_detail.dart';

abstract class AdRepository {
  Future<List<Ad>> getHomeAds(int pageIndex, int pageSize, String keyWord);

  Future<List<Ad>> getHomePopularAds(int pageIndex, int pageSize);

  Future<List<Ad>> getCollectivePopularAds({
    required CollectiveType collectiveType,
    required int pageIndex,
    required int pageSize,
  });

  Future<List<Ad>> getCollectiveCheapAds({
    required CollectiveType collectiveType,
    required int pageIndex,
    required int pageSize,
  });

  Future<List<Ad>> getCollectiveAds(
      {required CollectiveType collectiveType,
      required int pageIndex,
      required int pageSize});

  Future<List<Ad>> getSellerAds({
    required int sellerTin,
    required int pageIndex,
    required int pageSize,
  });

  Future<List<Ad>> getSimilarAds({
    required int adId,
    required int pageIndex,
    required int pageSize,
  });

  Future<List<Ad>> getHotDiscountAds(
    CollectiveType collectiveType,
    int pageIndex,
    int pageSize,
  );

  Future<List<AdSearchResponse>> getSearch(String query);

  Future<AdDetail?> getAdDetail(int adId);
}

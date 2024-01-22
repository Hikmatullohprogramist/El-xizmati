import 'package:onlinebozor/domain/util.dart';

import '../../data/responses/search/search_response.dart';
import '../models/ad.dart';
import '../models/ad_detail.dart';

abstract class AdRepository {
  Future<List<Ad>> getHomeAds(int page, int limit, String keyWord);

  Future<List<Ad>> getPopularAdsByType({
    required AdType adType,
    required int page,
    required int limit,
  });

  Future<List<Ad>> getCheapAdsByType({
    required AdType adType,
    required int page,
    required int limit,
  });

  Future<List<Ad>> getAdsByType({
    required AdType adType,
    required int page,
    required int limit,
  });

  Future<List<Ad>> getHotDiscountAdsByType(
    AdType adType,
    int page,
    int pageSize,
  );

  Future<List<Ad>> getSellerAds({
    required int sellerTin,
    required int page,
    required int limit,
  });

  Future<List<Ad>> getSimilarAds({
    required int adId,
    required int page,
    required int limit,
  });

  Future<List<AdSearchResponse>> getSearch(String query);

  Future<AdDetail?> getAdDetail(int adId);

  Future<void> increaseAdStats({required StatsType type, required int adId});

  Future<void> addAdToRecentlyViewed({required int adId});

  Future<List<Ad>> getRecentlyViewedAds({
    required int page,
    required int limit,
  });
}

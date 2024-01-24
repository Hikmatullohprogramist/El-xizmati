import '../../data/responses/search/search_response.dart';
import '../models/ad/ad.dart';
import '../models/ad/ad_detail.dart';
import '../models/ad/ad_type.dart';
import '../models/stats/stats_type.dart';

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

  Future<List<Ad>> getAdsByUser({
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

import '../../data/model/ads/ad/ad_response.dart';
import '../../data/model/ads/ad_detail/ad_detail_response.dart';

abstract class AdRepository {
  Future<List<AdResponse>> getAds(int pageIndex, int pageSize, String keyWord);

  Future<List<AdResponse>> getRecentlyViewAds();

  Future<AdDetailResponse?> getAdDetail(int adId);

// Future<List<AdModel>> getAdModels(int pageIndex, int pageSize, String keyWord);
}

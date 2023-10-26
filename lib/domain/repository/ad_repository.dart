import '../../data/model/ads/ad_detail/ad_detail_response.dart';
import '../model/ad_model.dart';

abstract class AdRepository {
  Future<List<AdModel>> getAds(int pageIndex, int pageSize, String keyWord);

  Future<List<AdModel>> getRecentlyViewAds();

  Future<AdDetailResponse?> getAdDetail(int adId);

Future<List<AdModel>> getAdModels(int pageIndex, int pageSize, String keyWord);
}

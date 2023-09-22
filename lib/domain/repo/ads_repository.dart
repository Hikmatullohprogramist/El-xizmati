import 'package:onlinebozor/domain/model/ads/ads_response.dart';

import '../model/banner/banner_response.dart';

abstract class AdsRepository {
  Future<List<AdsResponse>> getAds(int pageIndex, int pageSize);

  Future<List<BannerResponse>> getBanner();
}

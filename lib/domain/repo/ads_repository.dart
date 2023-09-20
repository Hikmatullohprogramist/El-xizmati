import 'package:onlinebozor/domain/model/ads/ads_response.dart';

abstract class AdsRepository {
  Future<AdsResponse> getAds(int pageIndex, int pageSize);
}

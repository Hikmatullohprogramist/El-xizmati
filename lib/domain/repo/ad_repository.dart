import 'package:onlinebozor/domain/model/ad/ad_response.dart';

import '../model/banner/banner_response.dart';

abstract class AdRepository {
  Future<List<AdResponse>> getAds(int pageIndex, int pageSize);

  Future<List<AdResponse>> getRecentlyViewAds();
}

import 'package:onlinebozor/domain/model/ad/ad_response.dart';

abstract class AdRepository {
  Future<List<AdResponse>> getAds(int pageIndex, int pageSize, String keyWord);

  Future<List<AdResponse>> getRecentlyViewAds();
}

import 'package:onlinebozor/data/responses/user_ad/user_ad_response.dart';

abstract class UserAdRepository {
  Future<List<UserAdResponse>> getUserAds(int pageSiz, int pageIndex);
}

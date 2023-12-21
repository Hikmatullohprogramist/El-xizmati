import 'package:onlinebozor/data/responses/user_ad/user_ad_response.dart';

import '../util.dart';

abstract class UserAdRepository {
  Future<List<UserAdResponse>> getUserAds(
      {required int pageSize,
      required int pageIndex,
      required UserAdStatus userAdType});
}

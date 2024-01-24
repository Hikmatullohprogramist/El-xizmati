import 'package:onlinebozor/data/responses/user_ad/user_ad_response.dart';

import '../models/ad/user_ad_status.dart';

abstract class UserAdRepository {
  Future<List<UserAdResponse>> getUserAds({
    required int page,
    required int limit,
    required UserAdStatus userAdStatus,
  });
}

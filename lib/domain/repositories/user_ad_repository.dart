import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/responses/user_ad/user_ad_response.dart';

import '../models/ad/user_ad_status.dart';
import '../../data/services/user_ad_service.dart';

@LazySingleton()
class UserAdRepository {
  UserAdRepository(this.userAdService);

  final UserAdService userAdService;

  Future<List<UserAdResponse>> getUserAds({
    required int page,
    required int limit,
    required UserAdStatus userAdStatus,
  }) async {
    final response = await userAdService.getUserAds(
      page: page,
      limit: limit,
      userAdType: userAdStatus,
    );

    final userAdResponse =
        UserAdRootResponse.fromJson(response.data).data.results;
    return userAdResponse;
  }
}

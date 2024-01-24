import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/responses/user_ad/user_ad_response.dart';
import 'package:onlinebozor/domain/repositories/user_ad_repository.dart';

import '../../domain/models/ad/user_ad_status.dart';
import '../services/user_ad_service.dart';

@LazySingleton(as: UserAdRepository)
class UserAdRepositoryImp extends UserAdRepository {
  UserAdRepositoryImp(this.userAdService);

  final UserAdService userAdService;

  @override
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

import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/responses/user_ad/user_ad_response.dart';
import 'package:onlinebozor/domain/repositories/user_ad_repository.dart';

import '../../domain/util.dart';
import '../services/user_ad_service.dart';

@LazySingleton(as: UserAdRepository)
class UserAdRepositoryImp extends UserAdRepository {
  UserAdRepositoryImp(this.userAdService);

  final UserAdService userAdService;

  @override
  Future<List<UserAdResponse>> getUserAds(
      {required int pageSize,
      required int pageIndex,
      required UserAdStatus userAdType}) async {
    final response = await userAdService.getUserAds(
        pageSiz: pageSize, pageIndex: pageIndex, userAdType: userAdType);
    final userAdResponse =
        UserAdRootResponse.fromJson(response.data).data.results;
    return userAdResponse;
  }
}

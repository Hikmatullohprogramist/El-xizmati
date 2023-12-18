import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/responses/user_ad/user_ad_response.dart';
import 'package:onlinebozor/domain/repositories/user_ad_repository.dart';

import '../services/user_ad_service.dart';

@LazySingleton(as: UserAdRepository)
class UserAdRepositoryImp extends UserAdRepository {
  UserAdRepositoryImp(this.userAdService);

  final UserAdService userAdService;

  @override
  Future<List<UserAdResponse>> getUserAds(int pageSiz, int pageIndex) async {
    final response = await userAdService.getUserAds(pageSiz, pageIndex);
    final userAdResponse =
        UserAdRootResponse.fromJson(response.data).data.results;
    return userAdResponse;
  }
}

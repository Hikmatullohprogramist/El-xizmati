import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/repositories/user_ad_repository.dart';

import '../services/user_ad_service.dart';

@LazySingleton(as: UserAdRepository)
class UserAdRepositoryImp extends UserAdRepository {
  UserAdRepositoryImp(this.userAdService);

  final UserAdService userAdService;

  @override
  Future<void> getUserAds(int pageSiz, int pageIndex) async {
    await userAdService.getUserAds(pageSiz, pageIndex);
    return;
  }
}

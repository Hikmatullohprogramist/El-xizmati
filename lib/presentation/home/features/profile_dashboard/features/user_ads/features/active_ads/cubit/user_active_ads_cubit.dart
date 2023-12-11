import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../common/core/base_cubit.dart';
import '../../../../../../../../../data/services/user_ad_service.dart';

part 'user_active_ads_cubit.freezed.dart';
part 'user_active_ads_state.dart';

@Injectable()
class UserActiveAdsCubit
    extends BaseCubit<UserActiveAdsBuildable, UserActiveAdsListenable> {
  UserActiveAdsCubit(this.userAdService)
      : super(const UserActiveAdsBuildable()) {
    getUserAds();
  }

  final UserAdService userAdService;

  Future<void> getUserAds() async {
    await userAdService.getUserAds(20, 1);
  }
}

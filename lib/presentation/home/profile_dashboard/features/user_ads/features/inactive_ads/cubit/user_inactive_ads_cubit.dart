import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'user_inactive_ads_cubit.freezed.dart';

part 'user_inactive_ads_state.dart';

@Injectable()
class UserInactiveAdsCubit
    extends BaseCubit<UserInactiveAdsBuildable, UserInactiveAdsListenable> {
  UserInactiveAdsCubit() : super(const UserInactiveAdsBuildable());
}

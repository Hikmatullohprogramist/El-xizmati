import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'user_pending_ads_cubit.freezed.dart';

part 'user_pending_ads_state.dart';

@Injectable()
class UserPendingAdsCubit
    extends BaseCubit<UserPendingAdsBuildable, UserPendingAdsListenable> {
  UserPendingAdsCubit() : super(const UserPendingAdsBuildable());
}

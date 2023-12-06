import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../common/core/base_cubit_new.dart';

part 'user_pending_ads_cubit.freezed.dart';

part 'user_pending_ads_state.dart';

@Injectable()
class UserPendingAdsCubit
    extends BaseCubit<UserPendingAdsBuildable, UserPendingAdsListenable> {
  UserPendingAdsCubit() : super(const UserPendingAdsBuildable());
}

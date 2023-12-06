import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../common/core/base_cubit_new.dart';
part 'user_inactive_ads_cubit.freezed.dart';

part 'user_inactive_ads_state.dart';

@Injectable()
class UserInactiveAdsCubit
    extends BaseCubit<UserInactiveAdsBuildable, UserInactiveAdsListenable> {
  UserInactiveAdsCubit() : super(const UserInactiveAdsBuildable());
}

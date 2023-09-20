import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/core/base_cubit.dart';

part 'profile_dashboard_cubit.freezed.dart';

part 'profile_dashboard_state.dart';

@injectable
class ProfileDashboardCubit
    extends BaseCubit<ProfileDashboardBuildable, ProfileDashboardListenable> {
  ProfileDashboardCubit() : super(ProfileDashboardBuildable());
}

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/domain/repository/auth_repository.dart';

import '../../../../../common/core/base_cubit.dart';
import '../../../../../domain/repository/state_repository.dart';

part 'profile_dashboard_cubit.freezed.dart';

part 'profile_dashboard_state.dart';

@injectable
class ProfileDashboardCubit
    extends BaseCubit<ProfileDashboardBuildable, ProfileDashboardListenable> {
  ProfileDashboardCubit(this.authRepository, this.stateRepository)
      : super(ProfileDashboardBuildable()) {
    isLogin();
  }

  final AuthRepository authRepository;
  final StateRepository stateRepository;

  Future<void> logOut() async {
    try {
      log.w("logOut call");
      await authRepository.logOut();
    } on DioException catch (e) {
      display.error(Strings.loadingStateError);
    }
  }

  Future<void> isLogin() async {
    final isLogin = await stateRepository.isLogin() ?? false;
    build((buildable) => buildable.copyWith(isLogin: isLogin));
  }


}

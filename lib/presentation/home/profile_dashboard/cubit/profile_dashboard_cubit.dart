import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/repository/auth_repository.dart';

import '../../../../common/core/base_cubit.dart';

part 'profile_dashboard_cubit.freezed.dart';
part 'profile_dashboard_state.dart';

@injectable
class ProfileDashboardCubit
    extends BaseCubit<ProfileDashboardBuildable, ProfileDashboardListenable> {
  ProfileDashboardCubit(this.authRepository)
      : super(ProfileDashboardBuildable());

  final AuthRepository authRepository;

  Future<void> logOut() async {
    try {
      log.w("logOut call");
      await authRepository.logOut();
    }on DioException  catch (e) {
      display.error("xatolik yuz berdi qayta urinib ko'ring ", "Xatolik");
    }
  }
}

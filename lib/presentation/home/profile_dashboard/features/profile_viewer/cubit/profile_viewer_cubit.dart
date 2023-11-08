import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/repository/auth_repository.dart';
import 'package:onlinebozor/domain/repository/user_repository.dart';

import '../../../../../../common/core/base_cubit.dart';

part 'profile_viewer_cubit.freezed.dart';
part 'profile_viewer_state.dart';

@injectable
class ProfileViewerCubit
    extends BaseCubit<ProfileViewerBuildable, ProfileViewerListenable> {
  ProfileViewerCubit(this._userRepository, this._authRepository)
      : super(ProfileViewerBuildable());

  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  Future<void> getUserInformation() async {
    try {
      final response = await _userRepository.getUserInformation();
      build((buildable) => buildable.copyWith(
          fullName: response.fullName ?? "*",
          phoneNumber: response.mobilePhone ?? "*",
          email: response.email ?? "*",
          biometricInformation:
              "${response.passportSerial ?? ""} ${response.passportNumber ?? ""}",
          brithDate: response.birthDate ?? "*",
          districtName: response.districtId ?? "*",
          regionName: response.regionId ?? "*",
          userName: response.username ?? "*",
          identified: response.isRegistered ?? false,
          streetName:
              "${response.mahallaId ?? ""}  ${response.homeName ?? ""}"));
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        logOut();
      }
      display.error(e.toString());
    }
  }

  Future<void> logOut() async {
    await _authRepository.logOut();
    invoke(ProfileViewerListenable(ProfileViewerEffect.navigationAuthStart));
  }
}

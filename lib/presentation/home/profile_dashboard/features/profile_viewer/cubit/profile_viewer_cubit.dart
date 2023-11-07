import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/repository/user_repository.dart';

import '../../../../../../common/core/base_cubit.dart';

part 'profile_viewer_cubit.freezed.dart';
part 'profile_viewer_state.dart';

@injectable
class ProfileViewerCubit
    extends BaseCubit<ProfileViewerBuildable, ProfileViewerListenable> {
  ProfileViewerCubit(this._userRepository) : super(ProfileViewerBuildable());

  final UserRepository _userRepository;

  Future<void> getUserInformation() async {
    try {
      final response = await _userRepository.getUserInformation();
      build((buildable) =>
          buildable.copyWith(
              fullName: response.fullName ?? "*",
              phoneNumber: response.mobilePhone ?? "*",
              email: response.email ?? "*",
              biometricInformation:
              "${response.passportSerial ?? ""} ${response.passportNumber ??
                  ""}",
              brithDate: response.birthDate ?? "*",
              districtName: response.districtId ?? "*",
              regionName: response.regionId ?? "*",
              userName: response.username ?? "*",
              identified: response.isRegistered ?? false,
              streetName:
              "${response.mahallaId ?? ""}  ${response.homeName ?? ""}"));
    } catch (e) {
      display.error(e.toString());
    }
  }
}

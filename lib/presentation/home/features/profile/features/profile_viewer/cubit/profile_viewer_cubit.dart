import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../common/core/base_cubit_new.dart';
import '../../../../../../../domain/repositories/auth_repository.dart';
import '../../../../../../../domain/repositories/user_repository.dart';

part 'profile_viewer_cubit.freezed.dart';
part 'profile_viewer_state.dart';

@injectable
class ProfileViewerCubit
    extends BaseCubit<ProfileViewerBuildable, ProfileViewerListenable> {
  ProfileViewerCubit(this._userRepository, this._authRepository)
      : super(ProfileViewerBuildable());

  final UserRepository _userRepository;
  final AuthRepository _authRepository;

  Future<void> getUser() async {
    await Future.wait([
      getRegions(),
      getDistrict(),
      getStreets(),
    ]);
  }

  Future<void> getUserInformation() async {
    try {
      build((buildable) => buildable.copyWith(isLoading: true));
      final response = await _userRepository.getFullUserInfo();
      build((buildable) => buildable.copyWith(
          userName: (response.full_name ?? "*"),
          fullName: response.full_name ?? "*",
          phoneNumber: response.mobile_phone ?? "*",
          email: response.email ?? "*",
          photo: response.photo,
          biometricInformation:
              "${response.passport_serial ?? ""} ${response.passport_number ?? ""}",
          brithDate: response.birth_date ?? "*",
          districtName: (response.district_id ?? "*").toString(),
          isRegistration: response.is_registered ?? false,
          regionId: response.region_id,
          districtId: response.district_id,
          gender: response.gender ?? "*",
          streetId: response.mahalla_id));
      await getUser();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        logOut();
      }
      // display.error(e.toString());
    }
  }

  Future<void> getRegions() async {
    final response = await _userRepository.getRegions();
    final regionList =
        response.where((element) => element.id == buildable.regionId);
    if (regionList.isNotEmpty) {
      build((buildable) => buildable.copyWith(
          regionName: regionList.first.name, isLoading: false));
    } else {
      build((buildable) =>
          buildable.copyWith(regionName: "topilmadi", isLoading: false));
    }
  }

  Future<void> getDistrict() async {
    final regionId = buildable.regionId;
    final response = await _userRepository.getDistricts(regionId ?? 14);
    build((buildable) => buildable.copyWith(
        districtName: response
            .where((element) => element.id == buildable.districtId)
            .first
            .name));
  }

  Future<void> getStreets() async {
    try {
      final districtId = buildable.districtId;
      final response = await _userRepository.getStreets(districtId ?? 1419);
      build((buildable) => buildable.copyWith(
          streetName: response
              .where((element) => element.id == buildable.streetId)
              .first
              .name,
          isLoading: false));
    } catch (e) {
      build((buildable) => buildable.copyWith(isLoading: false));
    }
  }

  Future<void> logOut() async {
    await _authRepository.logOut();
    invoke(ProfileViewerListenable(ProfileViewerEffect.navigationAuthStart));
  }
}

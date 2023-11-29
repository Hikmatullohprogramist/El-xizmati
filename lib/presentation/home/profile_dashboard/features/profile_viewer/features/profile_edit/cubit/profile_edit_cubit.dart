import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/model/region%20/region_response.dart';

import '../../../../../../../../common/base/base_cubit.dart';
import '../../../../../../../../domain/repository/user_repository.dart';

part 'profile_edit_cubit.freezed.dart';
part 'profile_edit_state.dart';

@injectable
class ProfileEditCubit
    extends BaseCubit<ProfileEditBuildable, ProfileEditListenable> {
  ProfileEditCubit(this._userRepository) : super(ProfileEditBuildable()) {
    getFullUserInfo();
  }

  final UserRepository _userRepository;

  Future<void> getUser() async {
    await Future.wait([
      getRegions(),
      getDistrict(),
      getStreets(),
    ]);
  }

  Future<void> getFullUserInfo() async {
    try {
      final response = await _userRepository.getFullUserInfo();
      build((buildable) => buildable.copyWith(
            userName: response.username ?? "",
            fullName: response.full_name ?? "",
            phoneNumber: response.mobile_phone ?? "",
            email: response.email ?? "",
            brithDate: response.birth_date ?? "",
            biometricNumber: response.passport_number ?? "",
            biometricSerial: response.passport_serial ?? "",
            apartmentNumber: response.home_name ?? "",
            districtId: response.district_id,
            regionId: response.region_id,
            streetId: response.mahalla_id,
            homeNumber: response.home_name.toString(),
          ));
      await getUser();
    } on DioException catch (e) {
      display.error(e.toString());
    }
  }

  Future<void> getRegions() async {
    final response = await _userRepository.getRegions();
    final regionList =
        response.where((element) => element.id == buildable.regionId);
    if (regionList.isNotEmpty) {
      build((buildable) => buildable.copyWith(
          regions: response,
          regionName: regionList.first.name,
          isLoading: false));
    } else {
      build(
          (buildable) => buildable.copyWith(regionName: "", isLoading: false));
    }
  }

  Future<void> getDistrict() async {
    final regionId = buildable.regionId;
    final response = await _userRepository.getDistricts(regionId ?? 14);
    if (buildable.districtId != null) {
      build((buildable) => buildable.copyWith(
          districts: response,
          districtName: response
              .where((element) => element.id == buildable.districtId)
              .first
              .name));
    } else {
      build((buildable) => buildable.copyWith(districts: response));
    }
  }

  Future<void> getStreets() async {
    try {
      final districtId = buildable.districtId;
      final response = await _userRepository.getStreets(districtId ?? 1419);
      if (buildable.streetId != null) {
        build((buildable) => buildable.copyWith(
            streets: response,
            streetName: response
                .where((element) => element.id == buildable.streetId)
                .first
                .name,
            isLoading: false));
      } else {
        build((buildable) =>
            buildable.copyWith(streets: response, isLoading: false));
      }
    } catch (e) {
      display.error("street error ${e}");
      build((buildable) => buildable.copyWith(isLoading: false));
    }
  }

  void setBiometricSerial(String serial) {
    build((buildable) => buildable.copyWith(biometricSerial: serial));
    profileEdit();
  }

  void setBiometricNumber(String number) {
    build((buildable) =>
        buildable.copyWith(biometricNumber: number.replaceAll(" ", "")));
    profileEdit();
  }

  void setBrithDate(String brithDate) {
    build((buildable) => buildable.copyWith(brithDate: brithDate));
    profileEdit();
  }

  void setPhoneNumber(String phone) {
    build((buildable) => buildable.copyWith(
        phoneNumber: phone.replaceAll(" ", "").replaceAll("+", "")));
    profileEdit();
  }

  void setRegion(RegionResponse region) {
    build((buildable) => buildable.copyWith(
        regionId: region.id,
        regionName: region.name,
        districtId: null,
        districtName: "",
        streetId: null,
        streetName: ""));
    getDistrict();
  }

  void setDistrict(RegionResponse district) {
    build((buildable) => buildable.copyWith(
        districtId: district.id,
        districtName: district.name,
        streetId: null,
        streetName: ""));
    getStreets();
  }

  void setStreet(RegionResponse street) {
    build((buildable) =>
        buildable.copyWith(streetId: street.id, streetName: street.name));
  }

  Future<void> profileEdit() async {
    if (buildable.phoneNumber.length >= 12 &&
        buildable.biometricSerial.length >= 2 &&
        buildable.biometricNumber.length >= 7 &&
        buildable.brithDate.length >= 10) {
      try {} catch (e) {}
      return;
    }
  }
}

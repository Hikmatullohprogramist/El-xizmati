import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/domain/repository/user_repository.dart';

import '../../../../../../../../common/core/base_cubit_new.dart';
import '../../../../../../../../data/model/region /region_response.dart';

part 'registration_cubit.freezed.dart';
part 'registration_state.dart';

@Injectable()
class RegistrationCubit
    extends BaseCubit<RegistrationBuildable, RegistrationListenable> {
  RegistrationCubit(this._userRepository)
      : super(const RegistrationBuildable());

  final UserRepository _userRepository;

  void setBiometricSerial(String serial) {
    build((buildable) => buildable.copyWith(biometricSerial: serial));
  }

  void setBiometricNumber(String number) {
    build((buildable) =>
        buildable.copyWith(biometricNumber: number.replaceAll(" ", "")));
  }

  void setBrithDate(String brithDate) {
    build((buildable) => buildable.copyWith(brithDate: brithDate));
  }

  void setPhoneNumber(String phone) {
    build((buildable) => buildable.copyWith(
        mobileNumber: phone,
        phoneNumber: phone.replaceAll(" ", "").replaceAll("+", "")));
  }

  Future<void> validationAndRequest() async {
    if (buildable.phoneNumber.length >= 12 &&
        buildable.biometricSerial.length >= 2 &&
        buildable.biometricNumber.length >= 7 &&
        buildable.brithDate.length >= 10) {
      getUserInformation();
    } else {
      display.error(Strings.profileEditUnfullInformation);
    }
  }

  Future<void> getUserInformation() async {
    try {
      final response = await _userRepository.getBiometricInfo(
          phoneNumber: buildable.phoneNumber,
          biometricSerial: buildable.biometricSerial,
          biometricNumber: buildable.biometricNumber,
          brithDate: buildable.brithDate);
      if (response.status != "IN_PROCESS") {
        build((buildable) => buildable.copyWith(
            gender: response.passportInfo?.gender ?? "",
            userName: response.passportInfo?.full_name ?? "",
            biometricSerial: response.passportInfo?.series ?? "",
            biometricNumber: response.passportInfo?.number ?? "",
            fullName: response.passportInfo?.full_name ?? "",
            brithDate: response.passportInfo?.birth_date ?? "",
            regionId: response.passportInfo?.region_id,
            districtId: response.passportInfo?.district_id,
            pinfl: response.passportInfo?.pinfl ?? -1,
            isRegistration: true));
      } else {
        await getUserInfo(response.secret_key ?? "", buildable.phoneNumber);
      }
      await getField();
    } catch (e) {
      display.error(e.toString());
    }
  }

  Future<void> getField() async {
    await Future.wait([
      getRegions(),
      getDistrict(),
      getStreets(),
    ]);
  }

  Future<void> getUserInfo(String secretKey, String phoneNumber) async {
    try {
      final response = await _userRepository.getUserInfo(
          phoneNumber: phoneNumber, secretKey: secretKey);
      build((buildable) => buildable.copyWith(
            gender: response.userInfo.gender,
            userName: response.userInfo.full_name ?? "",
            fullName: response.userInfo.full_name ?? "",
            biometricNumber: response.userInfo.pass_number ?? "",
            biometricSerial: response.userInfo.pass_serial ?? "",
            pinfl: response.userInfo.pinfl,
            tin: response.userInfo.tin,
            brithDate: response.userInfo.birth_date ?? "",
            isRegistration: true,
            districtId: response.userInfo.district_id,
            regionId: response.userInfo.region_id,
          ));
    } catch (e) {
      display.error(Strings.loadingStateError);
    }
  }

  Future<void> sendUserInfo() async {
    try {
      await _userRepository.sendUserInformation(
          email: buildable.email,
          gender: buildable.gender ?? "",
          homeName: buildable.streetName,
          mahallaId: buildable.streetId ?? -1,
          mobilePhone: buildable.mobileNumber ?? "",
          photo: "",
          pinfl: buildable.pinfl ?? -1,
          postName: buildable.postName ?? "",
          phoneNumber: buildable.phoneNumber);
      display.success("Muvaffaqiyatli saqlandi");
    } catch (e) {
      display.error(Strings.loadingStateError);
    }
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
      display.error("region is empty");
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
      display.error("district is empty");
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
        display.error("street is empty");
        build((buildable) =>
            buildable.copyWith(streets: response, isLoading: false));
      }
    } catch (e) {
      display.error("street error ${e}");
      build((buildable) => buildable.copyWith(isLoading: false));
    }
  }

  Future<void> setHomeNumber(String homeNumber) async {
    build((buildable) => buildable.copyWith(homeNumber: homeNumber));
  }

  Future<void> setApartmentNumber(String homeNumber) async {
    build((buildable) => buildable.copyWith(homeNumber: homeNumber));
  }

  Future<void> setEmailAddress(String email) async {
    build((buildable) => buildable.copyWith(email: email));
  }
}

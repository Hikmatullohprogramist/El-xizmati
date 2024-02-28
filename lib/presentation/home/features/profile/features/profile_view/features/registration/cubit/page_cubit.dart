import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';

import '../../../../../../../../../common/core/base_cubit.dart';
import '../../../../../../../../../data/repositories/user_repository.dart';
import '../../../../../../../../../data/responses/region/region_response.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.repository) : super(const PageState());

  final UserRepository repository;

  void setBiometricSerial(String serial) {
    updateState((state) => states.copyWith(biometricSerial: serial));
  }

  void setBiometricNumber(String number) {
    updateState(
        (state) => states.copyWith(biometricNumber: number.replaceAll(" ", "")));
  }

  void setBrithDate(String brithDate) {
    updateState((state) => states.copyWith(brithDate: brithDate));
  }

  void setPhoneNumber(String phone) {
    updateState((state) => states.copyWith(
        mobileNumber: phone,
        phoneNumber: phone.replaceAll(" ", "").replaceAll("+", "")));
  }

  Future<void> validationAndRequest() async {
    if (states.phoneNumber.length >= 12 &&
        states.biometricSerial.length >= 2 &&
        states.biometricNumber.length >= 7 &&
        states.brithDate.length >= 10) {
      getUserInformation();
    } else {
      display.error(Strings.profileEditUnfullInformation);
    }
  }

  Future<void> getUserInformation() async {
    try {
      final response = await repository.getBiometricInfo(
          phoneNumber: states.phoneNumber,
          biometricSerial: states.biometricSerial,
          biometricNumber: states.biometricNumber,
          brithDate: states.brithDate);
      if (response.status != "IN_PROCESS") {
        updateState((state) => states.copyWith(
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
        await getUserInfo(response.secret_key ?? "", states.phoneNumber);
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
      final response = await repository.getUserInfo(
          phoneNumber: phoneNumber, secretKey: secretKey);
      updateState((state) => states.copyWith(
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
      await repository.sendUserInformation(
          email: states.email,
          gender: states.gender ?? "",
          homeName: states.streetName,
          mahallaId: states.streetId ?? -1,
          mobilePhone: states.mobileNumber ?? "",
          photo: "",
          pinfl: states.pinfl ?? -1,
          postName: states.postName ?? "",
          phoneNumber: states.phoneNumber);
      display.success("Muvaffaqiyatli saqlandi");
    } catch (e) {
      display.error(Strings.loadingStateError);
    }
  }

  void setRegion(RegionResponse region) {
    updateState((state) => states.copyWith(
        regionId: region.id,
        regionName: region.name,
        districtId: null,
        districtName: "",
        streetId: null,
        streetName: ""));
    getDistrict();
  }

  void setDistrict(RegionResponse district) {
    updateState((state) => states.copyWith(
        districtId: district.id,
        districtName: district.name,
        streetId: null,
        streetName: ""));
    getStreets();
  }

  void setStreet(RegionResponse street) {
    updateState((state) =>
        states.copyWith(streetId: street.id, streetName: street.name));
  }

  Future<void> getRegions() async {
    final response = await repository.getRegions();
    final regionList =
        response.where((element) => element.id == states.regionId);
    if (regionList.isNotEmpty) {
      updateState((state) => states.copyWith(
          regions: response,
          regionName: regionList.first.name,
          isLoading: false));
    } else {
      display.error("region is empty");
      updateState((state) => states.copyWith(regionName: "", isLoading: false));
    }
  }

  Future<void> getDistrict() async {
    final regionId = states.regionId;
    final response = await repository.getDistricts(regionId ?? 14);
    if (states.districtId != null) {
      updateState((state) => states.copyWith(
          districts: response,
          districtName: response
              .where((element) => element.id == states.districtId)
              .first
              .name));
    } else {
      display.error("district is empty");
      updateState((state) => states.copyWith(districts: response));
    }
  }

  Future<void> getStreets() async {
    try {
      final districtId = states.districtId;
      final response = await repository.getStreets(districtId ?? 1419);
      if (states.streetId != null) {
        updateState((state) => states.copyWith(
            streets: response,
            streetName: response
                .where((element) => element.id == states.streetId)
                .first
                .name,
            isLoading: false));
      } else {
        display.error("street is empty");
        updateState(
            (state) => states.copyWith(streets: response, isLoading: false));
      }
    } catch (e) {
      display.error("street error $e");
      updateState((state) => states.copyWith(isLoading: false));
    }
  }

  Future<void> setHomeNumber(String homeNumber) async {
    updateState((state) => states.copyWith(homeNumber: homeNumber));
  }

  Future<void> setApartmentNumber(String homeNumber) async {
    updateState((state) => states.copyWith(homeNumber: homeNumber));
  }

  Future<void> setEmailAddress(String email) async {
    updateState((state) => states.copyWith(email: email));
  }
}

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';

import '../../../../../../../../../common/core/base_cubit.dart';
import '../../../../../../../../../data/repositories/user_repository.dart';
import '../../../../../../../../../data/responses/region/region_response.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.repository) : super(PageState()) {
    getFullUserInfo();
  }

  final UserRepository repository;

  Future<void> getUser() async {
    await Future.wait([
      getRegions(),
      getDistrict(),
      getStreets(),
    ]);
  }

  Future<void> getFullUserInfo() async {
    try {
      final response = await repository.getFullUserInfo();
      updateState((state) => states.copyWith(
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
            pinfl: response.pinfl,
            tin: response.tin,
            gender: response.gender,
            postName: response.post_name,
          ));
      await getUser();
    } on DioException catch (e) {
      display.error(e.toString());
    }
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
        updateState(
            (state) => states.copyWith(streets: response, isLoading: false));
      }
    } catch (e) {
      display.error("street error $e");
      updateState((state) => states.copyWith(isLoading: false));
    }
  }

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
        phoneNumber: phone.replaceAll(" ", "").replaceAll("+", "")));
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

  Future<void> sendUserInfo() async {
    try {
      await repository.sendUserInformation(
          email: states.email,
          gender: states.gender ?? "",
          homeName: states.streetName,
          mahallaId: states.streetId ?? -1,
          mobilePhone: states.mobileNumber ?? "",
          photo: states.photo ?? "",
          pinfl: states.pinfl ?? -1,
          postName: states.postName ?? "",
          phoneNumber: states.phoneNumber);
      display.success("Muvaffaqiyatli saqlandi");
    } catch (e) {
      display.error(Strings.loadingStateError);
    }
  }
}

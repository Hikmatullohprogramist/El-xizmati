import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/district/district.dart';
import 'package:onlinebozor/domain/models/region/region.dart';
import 'package:onlinebozor/domain/models/street/street.dart';

import '../../../../../../../../../common/core/base_cubit.dart';
import '../../../../../../../../../data/repositories/user_repository.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.repository) : super(PageState()) {
    getUserProfile();
  }

  final UserRepository repository;

  Future<void> getUser() async {
    await Future.wait([
      getRegions(),
      getDistrict(),
      getStreets(),
    ]);
  }

  Future<void> getUserProfile() async {
    try {
      final response = await repository.getFullUserInfo();
      updateState((state) => states.copyWith(
            userName: response.username ?? "",
            fullName: response.full_name?.capitalizePersonName() ?? "",
            phoneNumber: response.mobile_phone?.clearPhoneWithoutCode() ?? "",
            email: response.email ?? "",
            birthDate: response.birth_date ?? "",
            docNumber: response.passport_number ?? "",
            docSerial: response.passport_serial ?? "",
            apartmentNumber: response.home_name ?? "",
            districtId: response.district_id,
            regionId: response.region_id,
            neighborhoodId: response.mahalla_id,
            homeNumber: response.home_name.toString(),
            pinfl: response.pinfl,
            tin: response.tin,
            gender: response.gender,
            postName: response.post_name,
          ));
      await getUser();
    } catch (e) {
      log.w("getUserProfile error = ${e.toString()}");
    }
  }

  Future<bool> updateUserProfile() async {
    try {
      await repository.updateUserProfile(
        email: states.email,
        gender: states.gender ?? "",
        homeName: states.neighborhoodName,
        neighborhoodId: states.neighborhoodId ?? -1,
        mobilePhone: states.mobileNumber?.clearPhoneWithCode() ?? "",
        phoneNumber: states.phoneNumber.clearPhoneWithCode(),
        photo: states.photo ?? "",
        pinfl: states.pinfl ?? -1,
        docSerial: states.docSerial.toUpperCase(),
        docNumber: states.docNumber,
        birthDate: states.birthDate,
        postName: states.postName ?? "",
      );
      return true;
    } catch (e) {
      display.error(Strings.commonEmptyMessage);
      return false;
    }
  }

  Future<void> getRegions() async {
    final response = await repository.getRegions();
    final regionList = response.where((e) => e.id == states.regionId);
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
                .name,
          ));
    } else {
      updateState((state) => states.copyWith(districts: response));
    }
  }

  Future<void> getStreets() async {
    try {
      final districtId = states.districtId!;
      final neighborhoods = await repository.getNeighborhoods(districtId);
      if (states.neighborhoodId != null) {
        updateState((state) => states.copyWith(
              neighborhoods: neighborhoods,
              neighborhoodName: neighborhoods
                  .where((element) => element.id == states.neighborhoodId)
                  .first
                  .name,
              isLoading: false,
            ));
      } else {
        updateState((state) => states.copyWith(
              neighborhoods: neighborhoods,
              isLoading: false,
            ));
      }
    } catch (e) {
      display.error("street error $e");
      updateState((state) => states.copyWith(isLoading: false));
    }
  }

  void setDocSerial(String serial) {
    updateState((state) => states.copyWith(docSerial: serial));
  }

  void setDocNumber(String number) {
    updateState((state) => states.copyWith(
          docNumber: number.replaceAll(" ", ""),
        ));
  }

  void setBrithDate(String brithDate) {
    updateState((state) => states.copyWith(birthDate: brithDate));
  }

  void setEmail(String email) {
    updateState((state) => states.copyWith(email: email));
  }

  void setPhoneNumber(String phone) {
    updateState((state) => states.copyWith(
        phoneNumber: phone.replaceAll(" ", "").replaceAll("+", "")));
  }

  void setRegion(Region region) {
    updateState((state) => states.copyWith(
          regionId: region.id,
          regionName: region.name,
          districtId: null,
          districtName: "",
          neighborhoodId: null,
          neighborhoodName: "",
        ));
    getDistrict();
  }

  void setDistrict(District district) {
    updateState((state) => states.copyWith(
          districtId: district.id,
          districtName: district.name,
          neighborhoodId: null,
          neighborhoodName: "",
        ));
    getStreets();
  }

  void setStreet(Neighborhood neighborhood) {
    updateState((state) => states.copyWith(
          neighborhoodId: neighborhood.id,
          neighborhoodName: neighborhood.name,
        ));
  }
}

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/data/responses/profile/biometric_info/biometric_info_response.dart';
import 'package:onlinebozor/domain/models/district/district.dart';
import 'package:onlinebozor/domain/models/region/region.dart';

import '../../../../../../../../../common/core/base_cubit.dart';
import '../../../../../../../../../data/repositories/user_repository.dart';
import '../../../../../../../../../data/responses/profile/user_full/user_full_info_response.dart';
import '../../../../../../../../../domain/models/street/street.dart';
import '../../../../../../../../ad/ad_list/cubit/page_cubit.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.repository) : super(const PageState()) {
    // getUserInformation();
    getUserNumber();
    getField();
  }

  final UserRepository repository;


  Future<void> getUser() async {
    await Future.wait([
      getRegions(),
      getDistrict(),
      // getStreets(),
    ]);
  }

  void setBiometricSerial(String serial) {
    updateState((state) => states.copyWith(biometricSerial: serial));
  }

  void setBiometricNumber(String number) {
    updateState((state) =>
        states.copyWith(biometricNumber: number.replaceAll(" ", "")));
  }

  void setBrithDate(String brithDate) {
    updateState((state) => states.copyWith(brithDate: brithDate));
  }

  void setPhoneNumber(String phone) {
    updateState((state) => states.copyWith(
        mobileNumber: phone,
        phoneNumber: phone.replaceAll(" ", "").replaceAll("+", "")));
  }

  void setFullName(String fullName) {
    updateState((state) => states.copyWith(fullName: fullName));
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

  Future<void> getUserNumber() async {
    try {
      final response = await repository.getFullUserInfo();
      log.w(response.passport_number.toString());
    } on DioException catch (e) {
      display.error(e.toString());
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
      getNeighborhoods(),
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
          homeName: states.neighborhoodName,
          mahallaId: states.neighborhoodId ?? -1,
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

  Future<void> checkAvailableNumber() async {
    BiometricInfoRootResponse response;
    updateState((state) => state.copyWith(isLoading: true));
    try {
        response = await repository.checkAvailableNumber(
          phoneNumber: "998${states.phoneNumber}",
          biometricSerial: states.biometricSerial.trim(),
          biometricNumber: states.biometricNumber.trim(),
          brithDate: states.brithDate.trim());
          resultBottomSheet(response);



    } catch (e) {
      emitEvent(PageEvent(PageEventType.notFound));
      display.error(e.toString());
    }
    finally {
      updateState((state) => state.copyWith(isLoading:false));
    }
  }

  void resultBottomSheet(BiometricInfoRootResponse response){
     if(response.data.status=="REJECTED"){
       emitEvent(PageEvent(PageEventType.rejected));
     }
     if(response.data.status=="ACCEPTED"){
       emitEvent(PageEvent(PageEventType.success));
       updateState((state) => state.copyWith(
         isRegistration: true,
         districtId:response.data.passportInfo?.district_id,
         fullName: response.data.passportInfo?.full_name??"",
         regionName: states.regions.where((element) => element.id==response.data.passportInfo?.region_id,).first.name,
         districtName:states.districts.where((element) => element.id==response.data.passportInfo?.district_id,).first.name,
       ));
       getNeighborhoods();
     }


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
    getNeighborhoods();
  }

  void setStreet(Neighborhood neighborhood) {
    updateState((state) => states.copyWith(
          neighborhoodId: neighborhood.id,
          neighborhoodName: neighborhood.name,
        ));
  }

  void setNeighborhood(Neighborhood neighborhood) {
    updateState((state) => states.copyWith(
          neighborhoodId: neighborhood.id,
          neighborhoodName: neighborhood.name,
        ));
  }

  Future<void> getRegions() async {
    final response = await repository.getRegions();
    updateState((state) =>
        states.copyWith(regions: response, regionName: "", isLoading: false));
  }

  Future<void> getDistrict() async {
    final regionId = states.regionId;
    final response = await repository.getDistricts(regionId ?? 14);
    updateState((state) => states.copyWith(districts: response));
    // if (states.districtId != null) {
    //   updateState((state) => states.copyWith(
    //     districts: response,
    //     districtName: response
    //         .where((element) => element.id == states.districtId)
    //         .first
    //         .name,
    //   ));
    // } else {
    //   updateState((state) => states.copyWith(districts: response));
    // }
  }

  Future<void> getNeighborhoods() async {
    try {
      final districtId = states.districtId!;
      final neighborhoods = await repository.getNeighborhoods(districtId);
      updateState((state) => states.copyWith(
            neighborhoods: neighborhoods,
            isLoading: false,
          ));
      //  if (states.neighborhoodId != null) {
      //    updateState((state) => states.copyWith(
      //          neighborhoods: neighborhoods,
      //          neighborhoodName: neighborhoods
      //              .where((e) => e.id == states.neighborhoodId)
      //              .first
      //              .name,
      //          isLoading: false,
      //        ));
      //  } else {
      //    updateState((state) => states.copyWith(
      //          neighborhoods: neighborhoods,
      //          isLoading: false,
      //        ));
      //  }
    } catch (e) {
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

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/cubit/base_cubit.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/data/datasource/network/responses/profile/verify_identity/identity_document_response.dart';
import 'package:onlinebozor/data/repositories/user_repository.dart';
import 'package:onlinebozor/domain/models/district/district.dart';
import 'package:onlinebozor/domain/models/region/region.dart';
import 'package:onlinebozor/domain/models/street/street.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._userRepository) : super(const PageState()) {
    // getUserInformation();
    getUserNumber();
    getRegionAndDistricts();
  }

  final UserRepository _userRepository;

  Future<void> getUser() async {
    await Future.wait([
      getRegions(),
      getDistrict(),
    ]);
  }

  ///
  Future<void> validateWithBioDocs() async {
    updateState((state) => state.copyWith(isLoading: true));
    try {
      var response = await _userRepository.getIdentityDocument(
        phoneNumber: states.phoneNumber.clearPhoneWithCode(),
        docSerial: states.docSerial.trim(),
        docNumber: states.docNumber.trim(),
        brithDate: states.brithDate.trim(),
      );
      validateBioDocsResultBottomSheet(response);
    } catch (e) {
      emitEvent(PageEvent(PageEventType.notFound));
      snackBarManager.error(e.toString());
    } finally {
      updateState((state) => state.copyWith(isLoading: false));
    }
  }

  Future<void> validateUser() async {
    try {
      var response = await _userRepository.validateUser(
        birthDate: states.brithDate,
        districtId: states.districtId ?? 0,
        email: states.email,
        fullName: states.fullName,
        gender: states.gender ?? "",
        homeName: states.apartmentNumber,
        id: states.id ?? 0,
        mahallaId: states.neighborhoodId ?? 0,
        mobilePhone: states.phoneNumber,
        passportNumber: states.docNumber,
        passportSeries: states.docSerial,
        phoneNumber: states.phoneNumber,
        photo: "",
        pinfl: states.pinfl ?? 0,
        postName: "",
        region_Id: states.regionId ?? 0,
      );
    } catch (e) {
      emitEvent(PageEvent(PageEventType.notFound));
      snackBarManager.error(e.toString());
    } finally {
      updateState((state) => state.copyWith(isLoading: false));
    }
  }

  bool saveEnableButton() {
    if (states.neighborhoodName.isNotEmpty &&
        states.apartmentNumber.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void validateBioDocsResultBottomSheet(IdentityDocumentInfoResponse response) {
    if (response.status == "REJECTED") {
      emitEvent(PageEvent(PageEventType.rejected));
    }
    if (response.status == "ACCEPTED") {
      emitEvent(PageEvent(PageEventType.success));
      updateState((state) => state.copyWith(
            isRegistration: true,
            districtId: response.passportInfo?.districtId,
            fullName: response.passportInfo?.fullName ?? "",
            regionName: states.regions
                .where((e) => e.id == response.passportInfo?.regionId)
                .first
                .name,
            districtName: states.districts
                .where((e) => e.id == response.passportInfo?.districtId)
                .first
                .name,
            gender: response.passportInfo?.gender ?? "",
            pinfl: response.passportInfo?.pinfl,
            id: response.passportInfo?.tin,
            regionId: response.passportInfo?.regionId,
          ));

      getNeighborhoods();
    }
  }

  Future<void> validationAndRequest() async {
    if (states.phoneNumber.length >= 12 &&
        states.docSerial.length >= 2 &&
        states.docNumber.length >= 7 &&
        states.brithDate.length >= 10) {
      getUserInformation();
    } else {
      snackBarManager.error(Strings.profileEditUnfullInformation);
    }
  }

  Future<void> getUserNumber() async {
    try {
      final response = await _userRepository.getUser();
      logger.w(response.passport_number.toString());
    } catch (e) {
      snackBarManager.error(e.toString());
    }
  }

  Future<void> getUserInformation() async {
    try {
      final response = await _userRepository.getIdentityDocument(
        phoneNumber: states.phoneNumber,
        docSerial: states.docSerial,
        docNumber: states.docNumber,
        brithDate: states.brithDate,
      );
      if (response.status?.toUpperCase() != "IN_PROCESS") {
        updateState((state) => states.copyWith(
            gender: response.passportInfo?.gender ?? "",
            userName: response.passportInfo?.fullName ?? "",
            docSerial: response.passportInfo?.series ?? "",
            docNumber: response.passportInfo?.number ?? "",
            fullName: response.passportInfo?.fullName ?? "",
            brithDate: response.passportInfo?.birthDate ?? "",
            regionId: response.passportInfo?.regionId,
            districtId: response.passportInfo?.districtId,
            pinfl: response.passportInfo?.pinfl ?? -1,
            isRegistration: true));
      } else {
        await continueVerifyingIdentity(
          response.secretKey ?? "",
          states.phoneNumber,
        );
      }
      await getRegionAndDistricts();
    } catch (e) {
      snackBarManager.error(e.toString());
    }
  }

  Future<void> getRegionAndDistricts() async {
    await Future.wait([
      getRegions(),
      getDistrict(),
      getNeighborhoods(),
    ]);
  }

  Future<void> continueVerifyingIdentity(
    String secretKey,
    String phoneNumber,
  ) async {
    try {
      final response = await _userRepository.continueVerifyingIdentity(
        phoneNumber: phoneNumber,
        secretKey: secretKey,
      );
      updateState((state) => states.copyWith(
            gender: response.userInfo.gender,
            userName: response.userInfo.full_name ?? "",
            fullName: response.userInfo.full_name ?? "",
            docSerial: response.userInfo.pass_serial ?? "",
            docNumber: response.userInfo.pass_number ?? "",
            pinfl: response.userInfo.pinfl,
            tin: response.userInfo.tin,
            brithDate: response.userInfo.birth_date ?? "",
            isRegistration: true,
            districtId: response.userInfo.district_id,
            regionId: response.userInfo.region_id,
          ));
    } catch (e) {
      snackBarManager.error(Strings.commonEmptyMessage);
    }
  }

  Future<void> updateUserProfile() async {
    try {
      await _userRepository.updateUserProfile(
        email: states.email,
        gender: states.gender ?? "",
        homeName: states.neighborhoodName,
        neighborhoodId: states.neighborhoodId ?? -1,
        mobilePhone: states.mobileNumber?.clearPhoneWithCode() ?? "",
        photo: "",
        pinfl: states.pinfl ?? -1,
        birthDate: states.brithDate,
        docSerial: states.docSerial.toUpperCase(),
        docNumber: states.docNumber,
        postName: states.postName ?? "",
        phoneNumber: states.phoneNumber,
      );
      snackBarManager.success("Muvaffaqiyatli saqlandi");
    } catch (e) {
      snackBarManager.error(Strings.commonEmptyMessage);
    }
  }

  void setBiometricSerial(String serial) {
    updateState((state) => states.copyWith(docSerial: serial));
  }

  void setBiometricNumber(String number) {
    updateState((state) => states.copyWith(
          docNumber: number.replaceAll(" ", ""),
        ));
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
    final response = await _userRepository.getRegions();
    updateState((state) =>
        states.copyWith(regions: response, regionName: "", isLoading: false));
  }

  Future<void> getDistrict() async {
    final regionId = states.regionId;
    final response = await _userRepository.getDistricts(regionId ?? 14);
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
      final neighborhoods = await _userRepository.getNeighborhoods(districtId);
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

  Future<void> setApartmentNumber(String apartmentNumber) async {
    updateState((state) => states.copyWith(apartmentNumber: apartmentNumber));
  }

  Future<void> setEmailAddress(String email) async {
    updateState((state) => states.copyWith(email: email));
  }
}

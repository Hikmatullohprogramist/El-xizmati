import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/extensions/list_extensions.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/datasource/network/responses/profile/verify_identity/identity_document_response.dart';
import 'package:onlinebozor/data/repositories/user_repository.dart';
import 'package:onlinebozor/domain/models/district/district.dart';
import 'package:onlinebozor/domain/models/region/region.dart';
import 'package:onlinebozor/domain/models/street/street.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/presentation/support/extensions/extension_message_exts.dart';

part 'identity_verification_cubit.freezed.dart';
part 'identity_verification_state.dart';

@Injectable()
class IdentityVerificationCubit
    extends BaseCubit<IdentityVerificationState, IdentityVerificationEvent> {
  final UserRepository _userRepository;

  IdentityVerificationCubit(this._userRepository)
      : super(const IdentityVerificationState()) {
    getUserNumber();
    getRegions();
  }

  Future<void> getIdentityDocument() async {
    _userRepository
        .getIdentityDocument(
          phoneNumber: states.phoneNumber.clearPhoneWithCode(),
          docSeries: states.docSeries,
          docNumber: states.docNumber,
          brithDate: states.brithDate,
        )
        .initFuture()
        .onStart(() {})
        .onSuccess((data) async {
          logger.w("getIdentityDocument onSuccess info = ${data.passportInfo}");
          // if (data.status?.toUpperCase() != "IN_PROCESS") {
          if (data.status?.toUpperCase().contains("IN_PROCESS") == true) {
            await continueVerifyingIdentity(
              data.secretKey ?? "",
              states.phoneNumber,
            );
          } else {
            final info = data.passportInfo;
            if (info != null) {
              updateState((state) => states.copyWith(
                    gender: info.gender ?? "",
                    userName: info.fullName ?? "",
                    docSeries: info.series ?? "",
                    docNumber: info.number ?? "",
                    fullName: info.fullName ?? "",
                    brithDate: info.birthDate ?? "",
                    regionId: info.regionId,
                    regionName: states.regions
                            .firstIf((e) => e.id == info.regionId)
                            ?.name ??
                        "",
                    districtId: info.districtId,
                    pinfl: info.pinfl ?? -1,
                    isIdentityVerified: true,
                  ));
            }
          }

          getDistrict();
          getNeighborhoods();
        })
        .onError((error) {
          stateMessageManager.showErrorSnackBar(error.localizedMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> validateUser() async {
    _userRepository
        .validateUser(
          birthDate: states.brithDate,
          districtId: states.districtId ?? 0,
          email: states.email,
          fullName: states.fullName,
          gender: states.gender ?? "",
          homeName: states.apartmentNumber,
          id: states.id ?? 0,
          mahallaId: states.neighborhoodId ?? 0,
          mobilePhone: states.phoneNumber.clearPhoneWithCode(),
          docSeries: states.docSeries,
          docNumber: states.docNumber,
          phoneNumber: states.phoneNumber,
          photo: "",
          pinfl: states.pinfl ?? 0,
          postName: "",
          region_Id: states.regionId ?? 0,
        )
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(isLoading: true));
        })
        .onSuccess((data) {
          updateState((state) => state.copyWith(isLoading: false));
        })
        .onError((error) {
          updateState((state) => state.copyWith(isLoading: false));
          emitEvent(IdentityVerificationEvent(
              IdentityVerificationEventType.notFound));
          stateMessageManager.showErrorSnackBar(error.localizedMessage);
        })
        .onFinished(() {})
        .executeFuture();
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
      emitEvent(
          IdentityVerificationEvent(IdentityVerificationEventType.rejected));
    }
    if (response.status == "ACCEPTED") {
      emitEvent(
          IdentityVerificationEvent(IdentityVerificationEventType.success));
      updateState((state) => state.copyWith(
            isIdentityVerified: true,
            districtId: response.passportInfo?.districtId,
            fullName: response.passportInfo?.fullName ?? "",
            regionName: states.regions
                    .firstIf((e) => e.id == response.passportInfo?.regionId)
                    ?.name ??
                "",
            districtName: states.districts
                    .firstIf((e) => e.id == response.passportInfo?.districtId)
                    ?.name ??
                "",
            gender: response.passportInfo?.gender ?? "",
            pinfl: response.passportInfo?.pinfl,
            id: response.passportInfo?.tin,
            regionId: response.passportInfo?.regionId,
          ));

      getNeighborhoods();
    }
  }

  Future<void> validationAndRequest() async {
    if (states.phoneNumber.clearPhoneNumber().length >= 9 &&
        states.docSeries.trim().length >= 2 &&
        states.docNumber.trim().length >= 7 &&
        states.brithDate.trim().length >= 10) {
      getIdentityDocument();
    } else {
      stateMessageManager
          .showErrorSnackBar(Strings.profileEditUnfullInformation);
    }
  }

  Future<void> getUserNumber() async {
    _userRepository
        .getUser()
        .initFuture()
        .onSuccess((data) {
          logger.w(data.passport_number.toString());
        })
        .onError((error) {
          stateMessageManager.showErrorSnackBar(error.localizedMessage);
        })
        .onFinished(() {})
        .executeFuture();
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
            docSeries: response.userInfo.pass_serial ?? "",
            docNumber: response.userInfo.pass_number ?? "",
            pinfl: response.userInfo.pinfl,
            tin: response.userInfo.tin,
            brithDate: response.userInfo.birth_date ?? "",
            isIdentityVerified: true,
            districtId: response.userInfo.district_id,
            regionId: response.userInfo.region_id,
          ));
    } catch (e) {
      stateMessageManager.showErrorSnackBar(Strings.commonEmptyMessage);
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
        docSeries: states.docSeries.toUpperCase(),
        docNumber: states.docNumber,
        postName: states.postName ?? "",
        phoneNumber: states.phoneNumber,
      );
      stateMessageManager.showSuccessSnackBar("Muvaffaqiyatli saqlandi");
    } catch (e) {
      stateMessageManager.showErrorSnackBar(Strings.commonEmptyMessage);
    }
  }

  void setDocSeries(String docSeries) {
    updateState((state) => states.copyWith(docSeries: docSeries));
  }

  void setDocNumber(String docNumber) {
    updateState((state) => states.copyWith(
          docNumber: docNumber.replaceAll(" ", ""),
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

  getRegions() {
    _userRepository
        .getRegions()
        .initFuture()
        .onStart(() {})
        .onSuccess((data) {
          updateState((state) => states.copyWith(
                regions: data,
                regionName:
                    data.firstIf((e) => e.id == state.regionId)?.name ?? "",
                isLoading: false,
              ));
        })
        .onError((error) {})
        .onFinished(() {})
        .executeFuture();
  }

  getDistrict() {
    final regionId = states.regionId;
    if (regionId == null) return;

    _userRepository
        .getDistricts(regionId)
        .initFuture()
        .onStart(() {})
        .onSuccess((data) {
          updateState((state) => states.copyWith(
                districts: data,
                districtName:
                    data.firstIf((e) => e.id == states.districtId)?.name ?? "",
              ));
        })
        .onError((error) {
          stateMessageManager.showErrorBottomSheet(error.localizedMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }

  getNeighborhoods() {
    final districtId = states.districtId;
    if (districtId == null) return;

    _userRepository
        .getNeighborhoods(districtId)
        .initFuture()
        .onStart(() {})
        .onSuccess((data) {
          updateState((state) => states.copyWith(
                neighborhoods: data,
                neighborhoodName:
                    data.firstIf((e) => e.id == states.neighborhoodId)?.name ??
                        "",
                isLoading: false,
              ));
        })
        .onError((error) {
          stateMessageManager.showErrorBottomSheet(error.localizedMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> setHomeNumber(String homeNumber) async {
    updateState((state) => states.copyWith(houseNumber: homeNumber));
  }

  Future<void> setApartmentNumber(String apartmentNumber) async {
    updateState((state) => states.copyWith(apartmentNumber: apartmentNumber));
  }

  Future<void> setEmailAddress(String email) async {
    updateState((state) => states.copyWith(email: email));
  }
}

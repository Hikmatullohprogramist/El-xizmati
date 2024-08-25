import 'package:El_xizmati/data/datasource/floor/dao/user_entity_dao.dart';
import 'package:El_xizmati/data/datasource/network/responses/profile/user/user_info_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/profile/verify_identity/identity_document_response.dart';
import 'package:El_xizmati/data/datasource/network/services/private/identity_service.dart';
import 'package:El_xizmati/data/datasource/network/services/private/user_service.dart';
import 'package:El_xizmati/data/datasource/preference/auth_preferences.dart';
import 'package:El_xizmati/data/datasource/preference/user_preferences.dart';

class IdentityRepository {
  final IdentityService _identityService;
  final UserPreferences _userPreferences;

  IdentityRepository(
    this._identityService,
    this._userPreferences,
  );

  Future<IdentityDocumentInfoResponse> getIdentityDocument({
    required String phoneNumber,
    required String docSeries,
    required String docNumber,
    required String brithDate,
  }) async {
    final response = await _identityService.getIdentityDocument(
      phoneNumber: phoneNumber,
      biometricSerial: docSeries,
      biometricNumber: docNumber,
      brithDate: brithDate,
    );
    final result = IdentityDocumentRootResponse.fromJson(response.data).data;
    return result;
  }

  Future<UserInfoResponse> continueVerifyingIdentity({
    required String phoneNumber,
    required String secretKey,
  }) async {
    final response = await _identityService.continueVerifyingIdentity(
      secretKey: secretKey,
      phoneNumber: phoneNumber,
    );
    final responseResult = UserInfoRootResponse.fromJson(response.data).data;
    return responseResult;
  }

  Future<void> validateUser({
    required String birthDate,
    required int districtId,
    required String email,
    required String fullName,
    required String gender,
    required String homeName,
    required int id,
    required int mahallaId,
    required String mobilePhone,
    required String docSeries,
    required String docNumber,
    required String phoneNumber,
    required String photo,
    required int pinfl,
    required String postName,
    required int region_Id,
  }) async {
    await _identityService.validateUser(
        birthDate: birthDate,
        districtId: districtId,
        email: email,
        fullName: fullName,
        gender: gender,
        homeName: homeName,
        id: id,
        neighborhoodId: mahallaId,
        mobilePhone: mobilePhone,
        docSeries: docSeries,
        docNumber: docNumber,
        phoneNumber: phoneNumber,
        photo: photo,
        pinfl: pinfl,
        postName: postName,
        regionId: region_Id);
  }

  bool isIdentityVerified() {
    return _userPreferences.isIdentified;
  }

  bool isNotIdentified() {
    return !_userPreferences.isIdentified;
  }
}

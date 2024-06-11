import 'package:dio/dio.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_query_keys.dart';
import 'package:onlinebozor/domain/models/active_sessions/active_session.dart';
import 'package:onlinebozor/domain/models/social_account/social_account_info.dart';

class UserService {
  final Dio _dio;

  UserService(this._dio);

  Future<Response> getFullUserInfo() {
    final response = _dio.get("api/mobile/v1/user/profile");
    return response;
  }

  Future<Response> getIdentityDocument({
    required String phoneNumber,
    required String biometricSerial,
    required String biometricNumber,
    required String brithDate,
  }) {
    final body = {
      RestQueryKeys.phoneNumber: phoneNumber,
      RestQueryKeys.passportSerial: biometricSerial,
      RestQueryKeys.passportNumber: biometricNumber,
      RestQueryKeys.brithDate: brithDate
    };
    return _dio.post('api/mobile/v1/user/profile', data: body);
  }

  Future<Response> continueVerifyingIdentity({
    required String secretKey,
    required String phoneNumber,
  }) {
    final data = {
      RestQueryKeys.secretKey: secretKey,
      RestQueryKeys.phoneNumber: phoneNumber
    };
    return _dio.post(
      'api/mobile/v1/user/profile/verify/in_progress',
      data: data,
    );
  }

  Future<Response> updateUserProfile({
    required String email,
    required String gender,
    required String homeName,
    required int id,
    required int neighborhoodId,
    required String mobilePhone,
    required String photo,
    required int pinfl,
    required String docSerial,
    required String docNumber,
    required String birthDate,
    required String postName,
    required String phoneNumber,
  }) async {
    final data = {
      RestQueryKeys.email: email,
      RestQueryKeys.gender: gender,
      RestQueryKeys.homeName: homeName,
      RestQueryKeys.id: id,
      RestQueryKeys.neighborhoodId: neighborhoodId,
      RestQueryKeys.mobilePhone: mobilePhone,
      RestQueryKeys.phoneNumber: phoneNumber,
      RestQueryKeys.photo: photo,
      RestQueryKeys.pinfl: pinfl,
      "passport_serial": docSerial,
      "passport_number": docNumber,
      "birth_date": birthDate,
      RestQueryKeys.postName: postName,
    };
    final response =
        await _dio.post("api/mobile/v1/user/profile", queryParameters: data);
    return response;
  }

  Future<Response> validateUser({
    required String birthDate,
    required int districtId,
    required String email,
    required String fullName,
    required String gender,
    required String homeName,
    required int id,
    required int mahallaId,
    required String mobilePhone,
    required String passportNumber,
    required String passportSeries,
    required String phoneNumber,
    required String photo,
    required int pinfl,
    required String postName,
    required int region_Id,
  }) async {
    final queryParameters = {
      RestQueryKeys.brithDate: birthDate,
      RestQueryKeys.districtId: districtId,
      RestQueryKeys.email: email,
      RestQueryKeys.fullName: fullName,
      RestQueryKeys.gender: gender,
      RestQueryKeys.homeName: homeName,
      RestQueryKeys.id: id,
      RestQueryKeys.neighborhoodId: mahallaId,
      RestQueryKeys.mobilePhone: mobilePhone,
      RestQueryKeys.passportNumber: passportNumber,
      RestQueryKeys.passportSerial: passportSeries,
      RestQueryKeys.phoneNumber: phoneNumber,
      RestQueryKeys.photo: photo,
      RestQueryKeys.pinfl: pinfl,
      RestQueryKeys.postName: postName,
      RestQueryKeys.regionId: region_Id,
    };
    final response = await _dio.put("api/mobile/v1/user/profile",
        queryParameters: queryParameters);
    return response;
  }

  Future<Response> checkAvailableNumber({
    required String birthDate,
    required String bioDocNumber,
    required String bioDocSeries,
    required String phoneNumber,
  }) async {
    final data = {
      RestQueryKeys.brithDate: birthDate,
      RestQueryKeys.passportNumber: bioDocNumber,
      RestQueryKeys.passportSerial: bioDocSeries,
      RestQueryKeys.phoneNumber: phoneNumber,
    };
    final response = await _dio.post("api/v2/user/profile", data: data);
    return response;
  }

  Future<Response> getRegionAndDistricts() async {
    final response = await _dio.get("api/mobile/v1/regions-districts");
    return response;
  }

  Future<Response> getRegions() async {
    final response = await _dio.get("api/mobile/v1/regions");
    return response;
  }

  Future<Response> getDistricts(int regionId) async {
    final queryParameters = {RestQueryKeys.regionId: regionId};
    final response = await _dio.get("api/mobile/v1/districts/list",
        queryParameters: queryParameters);
    return response;
  }

  Future<Response> getStreets(int districtId) async {
    final queryParameters = {RestQueryKeys.districtId: districtId};
    final response = await _dio.get(
      'api/mobile/v1/street/list',
      queryParameters: queryParameters,
    );
    return response;
  }

  Future<Response> getActiveDevices() async {
    final response = await _dio.get("api/mobile/v1/profile/active");
    return response;
  }

  Future<void> removeActiveDevice(ActiveSession session) async {
    final queryParameters = {RestQueryKeys.id: session.id};
    await _dio.delete("api/v1/user/active", queryParameters: queryParameters);
    return;
  }

  Future<Response> updateNotificationSources({required String sources}) async {
    final data = {RestQueryKeys.messageType: sources};
    final response = await _dio.patch(
      "api/v1/mobile/user/update-notification-sources",
      data: data,
    );
    return response;
  }

  Future<Response> updateSocialAccountInfo({
    required List<SocialAccountInfo?> socials,
  }) async {
    final Map<String, dynamic> data = {
      'socials': socials
          .map((element) => {
                RestQueryKeys.socialId: element?.id,
                RestQueryKeys.socialIsLink: element?.isLink,
                RestQueryKeys.socialLink: element?.link,
                RestQueryKeys.socialStatus: element?.status,
                RestQueryKeys.socialTin: element?.tin,
                RestQueryKeys.socialType: element?.type,
                RestQueryKeys.socialViewNote: element?.viewNote,
              })
          .toList()
    };

    final response = await _dio.patch(
      "api/v1/mobile/user/update-social-accounts",
      data: data,
    );
    return response;
  }

  Future<Response> getSocialNetwork() async {
    final response = await _dio.get("api/mobile/v1/profile/social_medias");
    return response;
  }
}

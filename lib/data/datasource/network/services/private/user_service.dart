import 'package:dio/dio.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_query_keys.dart';
import 'package:onlinebozor/domain/models/active_sessions/active_session.dart';
import 'package:onlinebozor/domain/models/social_account/social_account_info.dart';

class UserService {
  final Dio _dio;

  UserService(this._dio);

  Future<Response> getUserProfile() {
    return _dio.get("api/mobile/v1/user/profile");
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
    final body = {
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
    final response = await _dio.post(
      "api/mobile/v1/user/profile",
      queryParameters: body,
    );
    return response;
  }

  Future<Response> validateUser({
    required int id,
    required int pinfl,
    required String birthDate,
    required String email,
    required String fullName,
    required String gender,
    required String homeName,
    required String mobilePhone,
    required String passportNumber,
    required String passportSeries,
    required String phoneNumber,
    required String photo,
    required String postName,
    required int regionId,
    required int districtId,
    required int neighborhoodId,
  }) async {
    final params = {
      RestQueryKeys.brithDate: birthDate,
      RestQueryKeys.districtId: districtId,
      RestQueryKeys.email: email,
      RestQueryKeys.fullName: fullName,
      RestQueryKeys.gender: gender,
      RestQueryKeys.homeName: homeName,
      RestQueryKeys.id: id,
      RestQueryKeys.neighborhoodId: neighborhoodId,
      RestQueryKeys.mobilePhone: mobilePhone,
      RestQueryKeys.passportNumber: passportNumber,
      RestQueryKeys.passportSerial: passportSeries,
      RestQueryKeys.phoneNumber: phoneNumber,
      RestQueryKeys.photo: photo,
      RestQueryKeys.pinfl: pinfl,
      RestQueryKeys.postName: postName,
      RestQueryKeys.regionId: regionId,
    };

    return await _dio.put(
      "api/mobile/v1/user/profile",
      queryParameters: params,
    );
  }

  Future<Response> checkAvailableNumber({
    required String birthDate,
    required String bioDocNumber,
    required String bioDocSeries,
    required String phoneNumber,
  }) async {
    final body = {
      RestQueryKeys.brithDate: birthDate,
      RestQueryKeys.passportNumber: bioDocNumber,
      RestQueryKeys.passportSerial: bioDocSeries,
      RestQueryKeys.phoneNumber: phoneNumber,
    };

    final response = await _dio.post("api/v2/user/profile", data: body);
    return response;
  }

  Future<Response> getRegionAndDistricts() async {
    final response = await _dio.get("api/mobile/v1/regions-districts");
    return response;
  }

  Future<Response> getRegions() {
    return _dio.get("api/mobile/v1/regions");
  }

  Future<Response> getDistricts(int regionId) {
    final params = {RestQueryKeys.regionId: regionId};

    return _dio.get(
      "api/mobile/v1/districts/list",
      queryParameters: params,
    );
  }

  Future<Response> getNeighborhoods(int districtId) {
    final params = {RestQueryKeys.districtId: districtId};

    return _dio.get(
      'api/mobile/v1/street/list',
      queryParameters: params,
    );
  }

  Future<Response> getActiveSessions() async {
    final response = await _dio.get("api/mobile/v1/profile/active");
    return response;
  }

  Future<void> removeActiveSession(ActiveSession session) async {
    final params = {RestQueryKeys.id: session.id};

    await _dio.delete("api/v1/user/active", queryParameters: params);
    return;
  }

  Future<Response> updateNotificationSources({required String sources}) async {
    final body = {RestQueryKeys.messageType: sources};

    final response = await _dio.patch(
      "api/v1/mobile/user/update-notification-sources",
      data: body,
    );
    return response;
  }

  Future<Response> updateSocialAccountInfo({
    required List<SocialAccountInfo?> socials,
  }) async {
    final Map<String, dynamic> body = {
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
      data: body,
    );
    return response;
  }

  Future<Response> getSocialNetwork() async {
    final response = await _dio.get("api/mobile/v1/profile/social_medias");
    return response;
  }
}

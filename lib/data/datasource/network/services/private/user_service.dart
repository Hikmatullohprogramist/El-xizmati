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

  Future<Response> updateUserProfile({
    required String email,
    required String gender,
    required String homeName,
    required int id,
    required int neighborhoodId,
    required String mobilePhone,
    required String photo,
    required int pinfl,
    required String docSeries,
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
      "passport_serial": docSeries,
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

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/constants/rest_query_keys.dart';
import 'package:onlinebozor/data/responses/profile/user_full/user_full_info_response.dart';
import 'package:onlinebozor/domain/models/active_sessions/active_session.dart';
import 'package:onlinebozor/domain/models/social/social_network.dart';

import '../storages/token_storage.dart';

@lazySingleton
class UserService {
  final Dio _dio;
  final TokenStorage tokenStorage;

  UserService(this._dio, this.tokenStorage);

  Future<Response> getFullUserInfo() {
    final response = _dio.get("api/mobile/v1/user/profile");
    return response;
  }

  Future<Response> getBiometricInfo({
    required String phoneNumber,
    required String biometricSerial,
    required String biometricNumber,
    required String brithDate,
  }) {
    final data = {
      RestQueryKeys.phoneNumber: phoneNumber,
      RestQueryKeys.passportSerial: biometricSerial,
      RestQueryKeys.passportNumber: biometricNumber,
      RestQueryKeys.brithDate: brithDate
    };
    return _dio.post('api/mobile/v1/user/profile', data: data);
  }

  Future<Response> getUserInfo({
    required String secretKey,
    required String phoneNumber,
  }) {
    final data = {
      RestQueryKeys.secretKey: secretKey,
      RestQueryKeys.phoneNumber: phoneNumber
    };
    return _dio.post('api/mobile/v1/user/profile/verify/in_progress', data: data);
  }

  Future<Response> sendUserInformation({
    required String email,
    required String gender,
    required String homeName,
    required int id,
    required int mahallaId,
    required String mobilePhone,
    required String photo,
    required int pinfl,
    required String postName,
    required String phoneNumber,
  }) async {
    final queryParameters = {
      RestQueryKeys.email: email,
      RestQueryKeys.gender: gender,
      RestQueryKeys.homeName: homeName,
      RestQueryKeys.id: id,
      RestQueryKeys.neighborhoodId: mahallaId,
      RestQueryKeys.mobilePhone: mobilePhone,
      RestQueryKeys.phoneNumber: phoneNumber,
      RestQueryKeys.photo: photo,
      RestQueryKeys.pinfl: pinfl,
      RestQueryKeys.postName: postName,
    };
    final response =
        await _dio.put("api/mobile/v1/user/profile", queryParameters: queryParameters);
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
    final response =
        await _dio.get("api/mobile/v1/districts/list", queryParameters: queryParameters);
    return response;
  }

  Future<Response> getStreets(int districtId) async {
    final queryParameters = {RestQueryKeys.districtId: districtId};
    final response =
        await _dio.get('api/mobile/v1/street/list', queryParameters: queryParameters);
    return response;
  }

  Future<Response> getActiveDevices() async {
    final response = await _dio.get("api/mobile/v1/profile/active");
    return response;
  }

  Future<Response> sendMessageType({required String messageType}) async {
    final queryParameters = {RestQueryKeys.messageType: messageType};
    final response = await _dio.patch("api/v1/user", data: queryParameters);
    return response;
  }

  Future<Response> sendSocials({
    required Social social
  }) async{
    final Map<String, dynamic> payload = {
      'socials': social.socials.map((element) => {
        RestQueryKeys.socialId: element.id,
        RestQueryKeys.socialIsLink: element.isLink,
        RestQueryKeys.socialLink: element.link,
        RestQueryKeys.socialStatus: element.status,
        RestQueryKeys.socialTin: element.tin,
        RestQueryKeys.socialType: element.type,
        RestQueryKeys.socialViewNote: element.viewNote,
      }).toList()
    };

    final response=
    await _dio.patch("api/v1/user/profile",data: payload);
    return response;
  }

  Future<void> removeActiveDevice(ActiveSession session) async {
    final queryParameters = {RestQueryKeys.id: session.id};
    await _dio.delete("api/v1/user/active", queryParameters: queryParameters);
    return;
  }

  Future<Response> getSocialNetwork() async {
    final response = await _dio.get("api/mobile/v1/profile/social_medias");
    return response;
  }
}

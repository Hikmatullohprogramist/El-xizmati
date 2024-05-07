import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/models/ad/user_ad_status.dart';

import '../constants/rest_query_keys.dart';

@lazySingleton
class UserAdService {
  final Dio _dio;

  UserAdService(this._dio);

  Future<Response> getUserAds({
    required int limit,
    required int page,
    required UserAdStatus userAdType,
  }) async {
    final params = {
      RestQueryKeys.limit: limit,
      RestQueryKeys.page: page,
      RestQueryKeys.status: userAdType.name.toUpperCase()
    };
    return _dio.get("api/mobile/v1/user/adsList", queryParameters: params);
  }

  Future<Response> deactivateAd(int adId) async {
    final params = {RestQueryKeys.adId: adId};
    return _dio.put("api/mobile/v1/deactivate-ad", queryParameters: params);
  }

  Future<Response> activateAd(int adId) async {
    final params = {RestQueryKeys.adId: adId};
    return _dio.put("api/mobile/v1/activate-ad", queryParameters: params);
  }

  Future<Response> deleteAd(int adId) async {
    final params = {RestQueryKeys.adId: adId};
    return _dio.put("api/mobile/v1/delete-ad", queryParameters: params);
  }
}

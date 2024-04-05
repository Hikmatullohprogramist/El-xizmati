import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/storages/token_storage.dart';

import '../../domain/models/ad/user_ad_status.dart';
import '../constants/rest_query_keys.dart';

@lazySingleton
class UserAdService {
  final Dio _dio;
  final TokenStorage tokenStorage;

  UserAdService(this._dio, this.tokenStorage);

  Future<Response> getUserAds({
    required int limit,
    required int page,
    required UserAdStatus userAdType,
  }) async {
    final queryParameters = {
      RestQueryKeys.limit: limit,
      RestQueryKeys.page: page,
      RestQueryKeys.status: userAdType.name.toUpperCase()
    };
    return _dio.get("api/mobile/v1/user/adsList", queryParameters: queryParameters);
  }

  Future<Response> deactivateAd(int adId) async {
    final query = {RestQueryKeys.adId: adId};
    return _dio.put("api/mobile/v1/deactivate-ad", queryParameters: query);
  }

  Future<Response> activateAd(int adId) async {
    final query = {RestQueryKeys.adId: adId};
    return _dio.put("api/mobile/v1/activate-ad", queryParameters: query);
  }

  Future<Response> deleteAd(int adId) async {
    final query = {RestQueryKeys.adId: adId};
    return _dio.put("api/mobile/v1/delete-ad", queryParameters: query);
  }
}

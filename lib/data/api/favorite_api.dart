import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/data/constants/rest_header_keys.dart';
import 'package:onlinebozor/data/constants/rest_query_keys.dart';
import 'package:onlinebozor/domain/model/ad.dart';

import '../storage/token_storage.dart';

@lazySingleton
class FavoriteApi {
  final Dio _dio;
  final TokenStorage tokenStorage;

  FavoriteApi(this._dio, this.tokenStorage);

  Future<Response> addFavorite({required String adType, required int id}) {
    final headers = {
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    final queryParameters = {
      RestQueryKeys.queryProductType: "ADS",
      RestQueryKeys.queryProductId: id,
      RestQueryKeys.queryNum: 1,
      RestQueryKeys.queryType: "SELECTED"
    };
    return _dio.post("v1/buyer/product",
        queryParameters: queryParameters, options: Options(headers: headers));
  }

  Future<Response> deleteFavorite(int adId) {
    final headers = {
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    final queryParameters = {RestQueryKeys.queryId: adId};
    return _dio.delete("v1/buyer/product",
        queryParameters: queryParameters, options: Options(headers: headers));
  }

  Future<Response> getFavoriteAds() {
    final headers = {
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    final queryParameters = {RestQueryKeys.queryType: "SELECTED"};
    return _dio.get("v1/buyer/products",
        queryParameters: queryParameters, options: Options(headers: headers));
  }

  Future<Response> sendAllFavoriteAds(List<Ad> ads) {
    final log = Logger();
    log.w(ads.toString());

    final data = {
      RestQueryKeys.queryProducts: [
        {
          RestQueryKeys.queryProductType: "ADS",
          RestQueryKeys.queryProductId: 372,
          RestQueryKeys.queryNum: 1,
          RestQueryKeys.queryType: "SELECTED"
        },
        {
          RestQueryKeys.queryProductType: "ADS",
          RestQueryKeys.queryProductId: 361,
          RestQueryKeys.queryNum: 1,
          RestQueryKeys.queryType: "SELECTED"
        },
        {
          RestQueryKeys.queryProductType: "ADS",
          RestQueryKeys.queryProductId: 871,
          RestQueryKeys.queryNum: 1,
          RestQueryKeys.queryType: "SELECTED"
        },
        {
          RestQueryKeys.queryProductType: "ADS",
          RestQueryKeys.queryProductId: 316,
          RestQueryKeys.queryNum: 1,
          RestQueryKeys.queryType: "SELECTED"
        },
      ]
    };
    final headers = {
      RestHeaderKeys.headerAuthorization: "Bearer ${tokenStorage.token.call()}"
    };
    return _dio.post("v1/buyer/products",
        data: data,
        options: Options(
          headers: headers,
        ));
  }
}

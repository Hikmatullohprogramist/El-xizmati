import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_query_keys.dart';

class FavoriteService {
  final Dio _dio;

  FavoriteService(this._dio);

  Future<Response> addToFavorite({required int adId}) {
    final params = {
      RestQueryKeys.productType: "ADS",
      RestQueryKeys.productId: adId,
      RestQueryKeys.number: 1,
      RestQueryKeys.type: "SELECTED"
    };
    return _dio.post("api/mobile/v1/buyer/product", queryParameters: params);
  }

  Future<Response> removeFromFavorite(int backedId) {
    final params = {
      RestQueryKeys.productId: backedId,
      RestQueryKeys.type: "SELECTED"
    };
    return _dio.delete("api/mobile/v1/buyer/product", queryParameters: params);
  }

  Future<Response> getFavoriteAds() {
    final params = {RestQueryKeys.type: "SELECTED"};
    return _dio.get("api/mobile/v1/buyer/products", queryParameters: params);
  }

  Future<Response> sendAllFavoriteAds(List<int> adIds) {
    final adsRequest = adIds.map((adId) {
      return {
        RestQueryKeys.productType: "ADS",
        RestQueryKeys.productId: adId,
        RestQueryKeys.number: 1,
        RestQueryKeys.type: "SELECTED"
      };
    });

    final body = {RestQueryKeys.products: jsonEncode(adsRequest)};
    return _dio.post("api/mobile/v1/buyer/products", data: body);
  }
}

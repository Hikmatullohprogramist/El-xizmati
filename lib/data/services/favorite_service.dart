import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/data/constants/rest_query_keys.dart';

import '../../domain/models/ad/ad.dart';
import '../storages/token_storage.dart';

@lazySingleton
class FavoriteService {
  final Dio _dio;
  final TokenStorage tokenStorage;

  FavoriteService(this._dio, this.tokenStorage);

  Future<Response> addFavorite({required String adType, required int id}) {
    final queryParameters = {
      RestQueryKeys.productType: "ADS",
      RestQueryKeys.productId: id,
      RestQueryKeys.number: 1,
      RestQueryKeys.type: "SELECTED"
    };
    return _dio.post("api/mobile/v1/buyer/product", queryParameters: queryParameters);
  }

  Future<Response> deleteFavorite(int backedId) {
    final queryParameters = {
      RestQueryKeys.productId: backedId,
      RestQueryKeys.type: "SELECTED"
    };
    return _dio.delete("api/mobile/v1/buyer/product", queryParameters: queryParameters);
  }

  Future<Response> getFavoriteAds() {
    final queryParameters = {RestQueryKeys.type: "SELECTED"};
    return _dio.get("api/mobile/v1/buyer/products", queryParameters: queryParameters);
  }

  Future<Response> sendAllFavoriteAds(List<Ad> ads) {
    final log = Logger();
    log.w(ads.toString());

    final adsRequest = ads.map((element) {
      return {
        RestQueryKeys.productType: "ADS",
        RestQueryKeys.productId: element.id,
        RestQueryKeys.number: 1,
        RestQueryKeys.type: "SELECTED"
      };
    });

    final data = {RestQueryKeys.products: jsonEncode(adsRequest)};
    return _dio.post("api/mobile/v1/buyer/products", data: data);
  }
}

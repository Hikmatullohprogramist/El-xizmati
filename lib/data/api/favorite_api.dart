import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/domain/mapper/ad_enum_mapper.dart';
import 'package:onlinebozor/domain/model/ad_model.dart';

import '../storage/token_storage.dart';

@lazySingleton
class FavoriteApi {
  final Dio _dio;
  final TokenStorage tokenStorage;

  FavoriteApi(this._dio, this.tokenStorage);

  Future<Response> addFavorite({required String adType, required int id}) {
    final headers = {"Authorization": "Bearer ${tokenStorage.token.call()}"};
    final queryParameters = {
      'product_type': "ADS",
      'product_id': id,
      'num': 1,
      "type": "SELECTED"
    };
    return _dio.post("v1/buyer/product",
        queryParameters: queryParameters, options: Options(headers: headers));
  }

  Future<Response> deleteFavorite(int adId) {
    final queryParameters = {
      'id': adId,
    };
    return _dio.delete("v1/buyer/products", queryParameters: queryParameters);
  }

  Future<Response> getFavoriteAds() {
    final headers = {"Authorization": "Bearer ${tokenStorage.token.call()}"};
    final queryParameters = {
      'type': "SELECTED",
    };
    return _dio.get("v1/buyer/products",
        queryParameters: queryParameters, options: Options(headers: headers));
  }

  Future<Response> sendAllFavoriteAds(List<AdModel> ads) {
    final log = Logger();
    log.w(ads.toString());
    final products = ads.map(
      (e) => {
        "product_type": e.adTypeStatus.adType().name(),
        "product_id": e.id,
        "num": 1,
        "type": "SELECTED"
      },
    );
    log.e(products.toString());
    final headers = {"Authorization": "Bearer ${tokenStorage.token.call()}"};
    final queryParameters = {
      'products': jsonEncode(products)
    };
    return _dio.post("v1/buyer/products",
        queryParameters: queryParameters, options: Options(headers: headers));
  }
}

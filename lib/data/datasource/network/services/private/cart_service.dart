import 'package:dio/dio.dart';
import 'package:El_xizmati/data/datasource/network/constants/rest_query_keys.dart';

class CartService {
  final Dio _dio;

  CartService(this._dio);

  Future<Response> addCart({required String adType, required int id}) {
    final params = {
      RestQueryKeys.productType: "ADS",
      RestQueryKeys.productId: id,
      RestQueryKeys.number: 1,
      RestQueryKeys.type: "BASKET"
    };
    return _dio.post("api/mobile/v1/buyer/product", queryParameters: params);
  }

  Future<Response> removeCart({required int adId}) {
    final params = {
      RestQueryKeys.productId: adId,
      RestQueryKeys.type: "BASKET"
    };
    return _dio.delete("api/mobile/v1/buyer/product", queryParameters: params);
  }

  Future<Response> getCartAllAds() {
    final params = {RestQueryKeys.type: 'BASKET'};
    return _dio.get("api/mobile/v1/buyer/products", queryParameters: params);
  }
}

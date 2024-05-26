import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_constants.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_query_keys.dart';

@LazySingleton()
class RealPayIntegrationService {
  RealPayIntegrationService(this._dio);

  final Dio _dio;

  Future<Response> getAddedCards() async {
    // api/realpay/v1/card/user-card/get-all?lang=la
    // https://online-bozor.uz/api/realpay/v1/card/user-card/get-all?lang=la
    return _dio.get("api/realpay/v1/card/user-card/get-all");
  }

  Future<Response> getPaymentMerchantToken(int tin, String redirectUri) async {
    final params = {
      RestQueryKeys.tin: tin,
      RestQueryKeys.customerType: RestConstants.REAL_PAY_TYPE_BUYER,
      RestQueryKeys.redirectUri: redirectUri
    };

    return _dio.post("api/realpay/v1/pan-payment", queryParameters: params);
  }

  Future<Response> getAddCardMerchantToken(int tin, String redirectUri) async {
    final params = {
      RestQueryKeys.tin: tin,
      RestQueryKeys.customerType: RestConstants.REAL_PAY_TYPE_ADD_CART,
      RestQueryKeys.redirectUri: redirectUri
    };

    return _dio.post("api/realpay/v1/add-card", queryParameters: params);
  }
}

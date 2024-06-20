import 'package:dio/dio.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_constants.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_query_keys.dart';

class PaymentService {
  final Dio _dio;

  PaymentService(this._dio);

  Future<Response> getTransactions(int page, int limit) async {
    return _dio.get("api/mobile/v1/user/billings");
  }

  Future<Response> getPaymentMerchantToken(int tin, String redirectUrl) async {
    final params = {
      RestQueryKeys.tin: tin,
      RestQueryKeys.customerType: RestConstants.REAL_PAY_TYPE_BUYER,
      RestQueryKeys.redirectUrl: redirectUrl
    };

    return _dio.post("api/realpay/v1/pan-payment", queryParameters: params);
  }

  Future<Response> getPaymentTransactionFilter() async {
    return _dio.get("api/mobile/v1/user/billings");
  }
}

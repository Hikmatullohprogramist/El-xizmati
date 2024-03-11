import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../storages/token_storage.dart';

@lazySingleton
class PaymentTransactionService {
  final Dio _dio;

  PaymentTransactionService(this._dio, this.tokenStorage);

  final TokenStorage tokenStorage;

  Future<Response> getPaymentTransaction({
    required int pageSize,
    required pageIndex,
  }) async {
    return _dio.get("api/mobile/v1/user/billings");
  }
  Future<Response> getPaymentTransactionFilter() async {
    return _dio.get("api/mobile/v1/user/billings");
  }
}

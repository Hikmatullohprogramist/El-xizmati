import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PaymentTransactionService {
  final Dio _dio;

  PaymentTransactionService(this._dio);

  Future<Response> getTransactions(int page, int limit) async {
    return _dio.get("api/mobile/v1/user/billings");
  }

  Future<Response> getPaymentTransactionFilter() async {
    return _dio.get("api/mobile/v1/user/billings");
  }
}

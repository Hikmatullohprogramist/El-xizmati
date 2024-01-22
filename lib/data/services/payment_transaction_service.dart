import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../constants/rest_header_keys.dart';
import '../storages/token_storage.dart';

@lazySingleton
class PaymentTransactionService {
  final Dio _dio;

  PaymentTransactionService(this._dio, this.tokenStorage);

  final TokenStorage tokenStorage;

  Future<Response> getPaymentTransaction(
      {required int pageSize, required pageIndex}) async {
    final headers = {
      RestHeaderKeys.authorization: "Bearer ${tokenStorage.token.call()}"
    };
    return _dio.get("v1/user/billings", options: Options(headers: headers));
  }
}
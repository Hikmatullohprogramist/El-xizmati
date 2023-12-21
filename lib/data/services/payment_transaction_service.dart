import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class PaymentTransactionService {
  final Dio _dio;
  PaymentTransactionService(this._dio);

  // mobile/v1/user/billings

 Future<Response> getPaymentTransaction({required int pageSize,required pageIndex}) async{
    return _dio.get("v1/user/billings");
  }

}
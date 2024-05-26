import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class CardService {
  CardService(this._dio);

  final Dio _dio;

  Future<Response> getUserBillings() async {
    return _dio.get("api/mobile/v1/user/billings");
  }

  Future<Response> getDepositBalance() async {
    return _dio.get("api/v1/user/balance");
  }
}

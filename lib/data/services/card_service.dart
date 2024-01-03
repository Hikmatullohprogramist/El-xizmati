

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class CardService {

  CardService(this._dio);

  final Dio _dio;

  // mobile/v1/user/billings

  Future<Response> getUserBillings() async{
    return _dio.get("v1/user/billings");
  }
}
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/storage/token_storage.dart';

@lazySingleton
class UserApi {
  final Dio _dio;
  final TokenStorage tokenStorage;

  UserApi(this._dio, this.tokenStorage);

  Future<Response> getUserInformation() {
    final headers = {"Authorization": "Bearer ${tokenStorage.token.call()}"};
    final response =
        _dio.get("v1/user/profile", options: Options(headers: headers));
    return response;
  }
}

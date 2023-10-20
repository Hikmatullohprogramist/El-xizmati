import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../data/storage/token_storage.dart';

@lazySingleton
class AuthInterceptor extends QueuedInterceptor {
  final TokenStorage tokenStorage;

  AuthInterceptor(this.tokenStorage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    String? token = tokenStorage.token.call();
    final headers = {'X-Api-Key': ""};
    // final headers = {};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    options.headers.addAll(headers);
    handler.next(options);
  }
}

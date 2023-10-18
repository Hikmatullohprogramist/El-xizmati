import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/storage/storage.dart';
import 'package:onlinebozor/domain/model/token/token.dart';

@lazySingleton
class AuthInterceptor extends QueuedInterceptor {
  final Storage storage;

  AuthInterceptor(this.storage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    Token? token = storage.token();
    final headers = {'X-Api-Key': ""};
    // final headers = {};
    if (token != null) {
      headers['Authorization'] = 'Bearer token.access';
    }
    options.headers.addAll(headers);
    handler.next(options);
  }
}

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:onlinebozor/data/datasource/network/constants/rest_query_keys.dart';

class EdsService {
  final Dio _dio;

  EdsService(this._dio);

  Future<http.Response> createDoc() async {
    final response = await http.post(
      Uri.parse('https://hujjat.uz/mobile-id/frontend/mobile/auth'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    return response;
  }

  Future<http.Response> checkStatus(String documentId, Timer? _timer) async {
    final response = await http.post(
      Uri.parse(
          'https://hujjat.uz/mobile-id/frontend/mobile/status?documentId=${documentId}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    return response;
  }

  Future<Response> signIn({
    required String sign,
  }) async {
    final body = {
      RestQueryKeys.accessToken: sign,
    };
    // return _dio.post('api/v2/mobile/auth/e-imzo/login', queryParameters: body);
    return _dio.get('auth/eimzo-v2/$sign');
  }
}

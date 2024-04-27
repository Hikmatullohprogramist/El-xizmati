import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/constants/rest_query_keys.dart';
import 'package:onlinebozor/domain/models/report/report_reason.dart';

import '../storages/token_storage.dart';

@lazySingleton
class ReportService {
  final Dio _dio;
  final TokenStorage tokenStorage;

  ReportService(this._dio, this.tokenStorage);

  Future<Response> submitAdReport({
    required int adId,
    required ReportReason reason,
    required String comment,
  }) async {
    final body = {
      "ad_id": adId,
      "reason": reason.name,
      "comment": comment
    };
    return _dio.post(
      'api/mobile/v1/ad/report-ad',
      data: body,
    );
  }

  Future<Response> submitAdBlock({
    required int adId,
    required ReportReason reason,
    required String comment,
  }) async {
    final body = {
      "ad_id": adId,
      "reason": reason.name,
      "comment": comment
    };
    return _dio.post(
      'api/mobile/v1/ad/block-ad',
      data: body,
    );
  }

  Future<Response> submitAdAuthorReport({
    required int tin,
    required ReportReason reason,
    required String comment,
  }) async {
    final body = {
      "user_tin": tin,
      "reason": reason.name,
      "comment": comment
    };
    return _dio.post(
      'api/mobile/v1/ad/report-ad-author',
      data: body,
    );
  }

  Future<Response> submitAdAuthorBlock({
    required int tin,
    required ReportReason reason,
    required String comment,
  }) async {
    final body = {
      "user_tin": tin,
      "reason": reason.name,
      "comment": comment
    };
    return _dio.post(
      'api/mobile/v1/ad/block-ad-author',
      data: body,
    );
  }
}

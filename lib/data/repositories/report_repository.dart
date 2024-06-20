import 'package:onlinebozor/data/datasource/network/services/public/report_service.dart';
import 'package:onlinebozor/domain/models/report/report_reason.dart';

class ReportRepository {
  final ReportService _reportService;

  ReportRepository(this._reportService);

  Future<void> submitAdReport({
    required int adId,
    required ReportReason reason,
    required String comment,
  }) async {
    await _reportService.submitAdReport(
      adId: adId,
      reason: reason,
      comment: comment,
    );
    return;
  }

  Future<void> submitAdBlock({
    required int adId,
    required ReportReason reason,
    required String comment,
  }) async {
    await _reportService.submitAdBlock(
      adId: adId,
      reason: reason,
      comment: comment,
    );
    return;
  }

  Future<void> submitAdAuthorReport({
    required int tin,
    required ReportReason reason,
    required String comment,
  }) async {
    await _reportService.submitAdAuthorReport(
      tin: tin,
      reason: reason,
      comment: comment,
    );
    return;
  }

  Future<void> submitAdAuthorBlock({
    required int tin,
    required ReportReason reason,
    required String comment,
  }) async {
    await _reportService.submitAdAuthorBlock(
      tin: tin,
      reason: reason,
      comment: comment,
    );
    return;
  }
}

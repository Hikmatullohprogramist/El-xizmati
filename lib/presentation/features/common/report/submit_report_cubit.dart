import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/core/enum/enums.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/data/repositories/report_repository.dart';
import 'package:El_xizmati/domain/models/report/report_reason.dart';
import 'package:El_xizmati/domain/models/report/report_type.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';
import 'package:El_xizmati/presentation/support/extensions/resource_exts.dart';

part 'submit_report_cubit.freezed.dart';
part 'submit_report_state.dart';

@Injectable()
class SubmitReportCubit
    extends BaseCubit<SubmitReportState, SubmitReportEvent> {
  final ReportRepository _reportRepository;

  SubmitReportCubit(this._reportRepository) : super(SubmitReportState());

  void setInitialParams(int idOrTin, ReportType reportType) {
    updateState((state) => state.copyWith(
          idOrTin: idOrTin,
          reportType: reportType,
          reasons: ReportReason.values,
        ));
  }

  Future<void> submitReport() async {
    updateState((state) => state.copyWith(loadState: LoadingState.loading));

    try {
      switch (states.reportType) {
        case ReportType.AD_BLOCK:
          await _reportRepository.submitAdBlock(
            adId: states.idOrTin,
            reason: states.selectedReason,
            comment: states.reportComment,
          );
        case ReportType.AD_REPORT:
          await _reportRepository.submitAdReport(
            adId: states.idOrTin,
            reason: states.selectedReason,
            comment: states.reportComment,
          );
        case ReportType.AUTHOR_BLOCK:
          await _reportRepository.submitAdAuthorBlock(
            tin: states.idOrTin,
            reason: states.selectedReason,
            comment: states.reportComment,
          );
        case ReportType.AUTHOR_REPORT:
          await _reportRepository.submitAdAuthorReport(
            tin: states.idOrTin,
            reason: states.selectedReason,
            comment: states.reportComment,
          );
      }

      updateState((state) => state.copyWith(loadState: LoadingState.success));

      logger.w("cancelOrder success");
      emitEvent(SubmitReportEvent(SubmitReportEventType.onClose));

      stateMessageManager.showSuccessBottomSheet(
        Strings.reportSuccessMessage,
        states.reportType.getLocalizedPageTitle(),
      );
    } catch (e) {
      logger.w("cancelOrder error = $e");
      updateState((state) => state.copyWith(loadState: LoadingState.error));
    }
  }

  void setSelectedReason(ReportReason reason) {
    updateState((state) => state.copyWith(
          selectedReason: reason,
          isCommentEnabled: reason == ReportReason.OTHER,
        ));
  }

  void setEnteredComment(String comment) {
    updateState((state) => state.copyWith(reportComment: comment));
  }
}

part of 'submit_report_cubit.dart';

@freezed
class SubmitReportState with _$SubmitReportState {
  const factory SubmitReportState({
    @Default(-1) int idOrTin,
    @Default(ReportType.AD_BLOCK) ReportType reportType,
    @Default([]) List<ReportReason> reasons,
    @Default(ReportReason.SPAM) ReportReason selectedReason,
    @Default("") String reportComment,
    @Default(false) bool isCommentEnabled,
    @Default(LoadingState.success) LoadingState loadState,
  }) = _SubmitReportState;
}

@freezed
class SubmitReportEvent with _$SubmitReportEvent {
  const factory SubmitReportEvent(SubmitReportEventType type) =
      _SubmitReportEvent;
}

enum SubmitReportEventType { onClose }

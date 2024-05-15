part of 'submit_report_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(-1) int idOrTin,
    @Default(ReportType.AD_BLOCK) ReportType reportType,
    @Default([]) List<ReportReason> reasons,
    @Default(ReportReason.SPAM) ReportReason selectedReason,
    @Default("") String reportComment,
    @Default(false) bool isCommentEnabled,
    @Default(LoadingState.success) LoadingState loadState,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType type) = _PageEvent;
}

enum PageEventType { onBackAfterCancel }

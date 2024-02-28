part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState() = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent({PageEventType? type}) = _PageEvent;
}

enum PageEventType { success }

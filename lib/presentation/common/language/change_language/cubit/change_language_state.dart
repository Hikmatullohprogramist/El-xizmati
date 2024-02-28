part of 'change_language_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({Language? language}) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType type) = _PageEvent;
}

enum PageEventType { backTo }

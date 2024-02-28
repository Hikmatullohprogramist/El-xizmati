part of 'auth_start_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState(
      {@Default("") String phone,
      @Default(false) bool validation,
      @Default(false) bool loading}) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType type, {String? phone}) = _PageEvent;
}

enum PageEventType { verification, confirmation }

part of 'user_active_sessions_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    PagingController<int, ActiveSession>? controller,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}

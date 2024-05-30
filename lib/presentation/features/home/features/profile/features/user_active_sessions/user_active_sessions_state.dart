part of 'user_active_sessions_cubit.dart';

@freezed
class UserActiveSessionsState with _$UserActiveSessionsState {
  const factory UserActiveSessionsState({
    PagingController<int, ActiveSession>? controller,
  }) = _UserActiveSessionsState;
}

@freezed
class UserActiveSessionsEvent with _$UserActiveSessionsEvent {
  const factory UserActiveSessionsEvent() = _UserActiveSessionsEvent;
}

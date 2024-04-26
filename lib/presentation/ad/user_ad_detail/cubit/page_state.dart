part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    UserAd? userAd,
    UserAdDetail? userAdDetail,
    @Default(LoadingState.loading) LoadingState loadState
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}

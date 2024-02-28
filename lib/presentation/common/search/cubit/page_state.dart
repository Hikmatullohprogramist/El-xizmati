part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(LoadingState.onStart) LoadingState loadingState,
    @Default(<AdSearchResponse>[]) List<AdSearchResponse> searchResult,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}

part of 'search_cubit.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState({
    @Default(LoadingState.none) LoadingState loadingState,
    @Default(<AdSearchResponse>[]) List<AdSearchResponse> searchResult,
  }) = _SearchState;
}

@freezed
class SearchEvent with _$SearchEvent {
  const factory SearchEvent() = _SearchEvent;
}

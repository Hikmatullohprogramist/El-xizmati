part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(<CategoryResponse>[]) List<CategoryResponse> items,
    @Default(0) int parentId,
    @Default(LoadingState.loading) LoadingState loadState,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}

part of 'selection_category_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(<CategorySelectionResponse>[])
    List<CategorySelectionResponse> items,
    @Default(LoadingState.loading) LoadingState itemsLoadState,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}

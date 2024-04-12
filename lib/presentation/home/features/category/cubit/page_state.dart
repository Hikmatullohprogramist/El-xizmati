part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(<CategoryResponse>[]) List<CategoryResponse> allItems,
    @Default(<CategoryResponse>[]) List<CategoryResponse> visibleItems,
    @Default(LoadingState.loading) LoadingState loadState,
    String? searchQuery,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(
    PageEventType type, {
    List<CategoryResponse>? categories,
    CategoryResponse? category,
  }) = _PageEvent;
}

enum PageEventType { onOpenSubCategory, onOpenProductList }

part of 'selection_nested_category_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    CategoryResponse? selectedCategory,
    @Default([]) List<CategoryResponse> allCategories,
    @Default([]) List<CategoryResponse> visibleCategories,
    @Default(LoadingState.loading) LoadingState categoriesState,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(
    PageEventType type, {
    CategoryResponse? category,
  }) = _PageEvent;
}

enum PageEventType { closePage }

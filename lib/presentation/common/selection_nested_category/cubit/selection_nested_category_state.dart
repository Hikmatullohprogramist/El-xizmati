part of 'selection_nested_category_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    CategoryResponse? selectedCategory,
    @Default(<CategoryResponse>[]) List<CategoryResponse> allCategories,
    @Default(<CategoryResponse>[]) List<CategoryResponse> categories,
    @Default(LoadingState.loading) LoadingState categoriesState,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(
    PageEventType pageEventType, {
    CategoryResponse? category,
  }) = _PageEvent;
}

enum PageEventType { closePage }

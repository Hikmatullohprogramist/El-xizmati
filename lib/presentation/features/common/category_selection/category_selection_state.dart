part of 'category_selection_cubit.dart';

@freezed
class CategorySelectionState with _$CategorySelectionState {
  const factory CategorySelectionState({
    @Default(AdType.PRODUCT) AdType adType,
    Category? selectedItem,
    @Default([]) List<Category> allItems,
    @Default([]) List<Category> visibleItems,
    @Default(LoadingState.loading) LoadingState loadState,
    String? searchQuery,
  }) = _CategorySelectionState;
}

@freezed
class CategorySelectionEvent with _$CategorySelectionEvent {
  const factory CategorySelectionEvent(
    CategorySelectionEventType type, {
    Category? category,
  }) = _CategorySelectionEvent;
}

enum CategorySelectionEventType { closePage }

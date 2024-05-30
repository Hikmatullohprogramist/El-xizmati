part of 'category_cubit.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState({
    @Default(<Category>[]) List<Category> allItems,
    @Default(<Category>[]) List<Category> visibleItems,
    @Default(LoadingState.loading) LoadingState loadState,
    String? searchQuery,
  }) = _CategoryState;
}

@freezed
class CategoryEvent with _$CategoryEvent {
  const factory CategoryEvent(
    CategoryEventType type, {
    List<Category>? categories,
    Category? category,
  }) = _CategoryEvent;
}

enum CategoryEventType { onOpenSubCategory, onOpenProductList }

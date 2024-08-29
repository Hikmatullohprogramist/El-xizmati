part of 'category_cubit.dart';

@freezed
class CategoryState with _$CategoryState {
  const factory CategoryState({
    @Default(<Results>[]) List<Results> allItems,
    @Default(<Results>[]) List<Results> visibleItems,
    @Default(LoadingState.loading) LoadingState loadState,
    String? searchQuery,
  }) = _CategoryState;
}

@freezed
class CategoryEvent with _$CategoryEvent {
  const factory CategoryEvent(
    CategoryEventType type, {
    List<Results>? categories,
    Results? category,
  }) = _CategoryEvent;
}

enum CategoryEventType { onOpenSubCategory, onOpenProductList }

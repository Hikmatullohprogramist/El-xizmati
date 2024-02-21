part of 'selection_nested_category_cubit.dart';

@freezed
class SelectionNestedCategoryBuildable with _$SelectionNestedCategoryBuildable {
  const factory SelectionNestedCategoryBuildable({
    CategoryResponse? selectedCategoryResponse,
    @Default(<CategoryResponse>[]) List<CategoryResponse> categories,
    @Default(<CategoryResponse>[]) List<CategoryResponse> selectCategories,
    @Default(LoadingState.loading) LoadingState categoriesState,
  }) = _SelectionNestedCategoryBuildable;
}

@freezed
class SelectionNestedCategoryListenable with _$SelectionNestedCategoryListenable {
  const factory SelectionNestedCategoryListenable(
    SelectionNestedCategoryEffect selectionCategoryEffect, {
    CategoryResponse? categoryResponse,
  }) = _SelectionNestedCategoryListenable;
}

enum SelectionNestedCategoryEffect { back }

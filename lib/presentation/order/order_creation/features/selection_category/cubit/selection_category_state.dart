part of 'selection_category_cubit.dart';

@freezed
class SelectionCategoryBuildable with _$SelectionCategoryBuildable {
  const factory SelectionCategoryBuildable(
      {CategoryResponse? selectedCategoryResponse,
      @Default(<CategoryResponse>[]) List<CategoryResponse> categories,
      @Default(<CategoryResponse>[]) List<CategoryResponse> selectCategories,
      @Default(AppLoadingState.loading)
      AppLoadingState categoriesState}) = _SelectionCategoryBuildable;
}

@freezed
class SelectionCategoryListenable with _$SelectionCategoryListenable {
  const factory SelectionCategoryListenable(
      SelectionCategoryEffect selectionCategoryEffect,
      {CategoryResponse? categoryResponse}) = _SelectionCategoryListenable;
}

enum SelectionCategoryEffect { back }

part of 'selection_category_cubit.dart';

@freezed
class SelectionCategoryBuildable with _$SelectionCategoryBuildable {
  const factory SelectionCategoryBuildable({
    @Default(<CategorySelectionResponse>[])
    List<CategorySelectionResponse> items,
    @Default(LoadingState.loading) LoadingState itemsLoadState,
  }) = _SelectionCategoryBuildable;
}

@freezed
class SelectionCategoryListenable with _$SelectionCategoryListenable {
  const factory SelectionCategoryListenable() = _SelectionCategoryListenable;
}

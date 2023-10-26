part of 'popular_categories_cubit.dart';

@freezed
class PopularCategoriesBuildable with _$PopularCategoriesBuildable {
  const factory PopularCategoriesBuildable({
    PagingController<int, PopularCategoryResponse>? categoriesPagingController,
    @Default(AppLoadingState.LOADING) AppLoadingState popularCategoriesState,
  }) = _PopularCategoriesBuildable;
}

@freezed
class PopularCategoriesListenable with _$PopularCategoriesListenable {
  const factory PopularCategoriesListenable(PopularCategoriesEffect effect,
      {String? message}) = _PopularCategoriesListenable;
}

enum PopularCategoriesEffect { success }

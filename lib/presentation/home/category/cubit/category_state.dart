part of 'category_cubit.dart';

@freezed
class CategoryBuildable with _$CategoryBuildable {
  const factory CategoryBuildable({
    @Default(<CategoryResponse>[]) List<CategoryResponse> categories,
    @Default(AppLoadingState.LOADING) AppLoadingState categoriesState
}) = _CategoryBuildable;
}

@freezed
class CategoryListenable with _$CategoryListenable {
  const factory CategoryListenable(CategoryEffect effect, {String? message}) =
  _CategoryListenable;
}

enum CategoryEffect { success }

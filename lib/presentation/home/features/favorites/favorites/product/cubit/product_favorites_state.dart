part of 'product_favorites_cubit.dart';

@freezed
class ProductFavoritesBuildable with _$ProductFavoritesBuildable {
  const factory ProductFavoritesBuildable({
    @Default("") String keyWord,
    @Default(AdListType.list) AdListType adListType,
    @Default(AppLoadingState.loading) AppLoadingState adsState,
    PagingController<int, Ad>? adsPagingController,
  }) = _ProductFavoritesBuildable;
}

@freezed
class ProductFavoritesListenable with _$ProductFavoritesListenable {
  const factory ProductFavoritesListenable() = _ProductFavoritesListenable;
}

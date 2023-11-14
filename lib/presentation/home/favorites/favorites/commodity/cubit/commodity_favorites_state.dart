part of 'commodity_favorites_cubit.dart';

@freezed
class CommodityFavoritesBuildable with _$CommodityFavoritesBuildable {
  const factory CommodityFavoritesBuildable({
    @Default("") String keyWord,
    @Default(AdListType.list) AdListType adListType,
    @Default(AppLoadingState.loading) AppLoadingState adsState,
    PagingController<int, AdModel>? adsPagingController,
  }) = _CommodityFavoritesBuildable;
}

@freezed
class CommodityFavoritesListenable with _$CommodityFavoritesListenable {
  const factory CommodityFavoritesListenable() = _CommodityFavoritesListenable;
}
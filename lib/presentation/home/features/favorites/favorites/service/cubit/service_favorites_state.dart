part of 'service_favorites_cubit.dart';

@freezed
class ServiceFavoritesBuildable with _$ServiceFavoritesBuildable {
  const factory ServiceFavoritesBuildable({
    @Default("") String keyWord,
    @Default(AdListType.homePopularAds) AdListType adListType,
    @Default(LoadingState.loading) LoadingState adsState,
    PagingController<int, Ad>? adsPagingController,
  }) = _ServiceFavoritesBuildable;
}

@freezed
class ServiceFavoritesListenable with _$ServiceFavoritesListenable {
  const factory ServiceFavoritesListenable() = _ServiceAdListenable;
}

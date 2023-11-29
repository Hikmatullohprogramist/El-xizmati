part of 'service_favorites_cubit.dart';

@freezed
class ServiceFavoritesBuildable with _$ServiceFavoritesBuildable {
  const factory ServiceFavoritesBuildable({
    @Default("") String keyWord,
    @Default(AdListType.list) AdListType adListType,
    @Default(AppLoadingState.loading) AppLoadingState adsState,
    PagingController<int, Ad>? adsPagingController,
  }) = _ServiceFavoritesBuildable;
}

@freezed
class ServiceFavoritesListenable with _$ServiceFavoritesListenable {
  const factory ServiceFavoritesListenable() = _ServiceAdListenable;
}

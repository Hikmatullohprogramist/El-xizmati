part of 'favorite_products_cubit.dart';

@freezed
class FavoriteProductsState with _$FavoriteProductsState {
  const factory FavoriteProductsState({
    @Default("") String keyWord,
    @Default(AdListType.homePopularAds) AdListType adListType,
    @Default(LoadingState.loading) LoadingState adsState,
    PagingController<int, Ad>? controller,
  }) = _FavoriteProductsState;
}

@freezed
class FavoriteProductsEvent with _$FavoriteProductsEvent {
  const factory FavoriteProductsEvent() = _FavoriteProductsEvent;
}

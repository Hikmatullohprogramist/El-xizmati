part of 'favorite_services_cubit.dart';

@freezed
class FavoriteServicesState with _$FavoriteServicesState {
  const factory FavoriteServicesState({
    @Default("") String keyWord,
    @Default(AdListType.homePopularAds) AdListType adListType,
    @Default(LoadingState.loading) LoadingState adsState,
    PagingController<int, Ad>? controller,
  }) = _FavoriteServicesState;
}

@freezed
class FavoriteServicesEvent with _$FavoriteServicesEvent {
  const factory FavoriteServicesEvent() = _FavoriteServicesEvent;
}

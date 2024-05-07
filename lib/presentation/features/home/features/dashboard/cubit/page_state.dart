part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const PageState._();

  @freezed
  const factory PageState({
    @Default([]) List<PopularCategory> popularCategories,
    @Default(LoadingState.loading) LoadingState popularCategoriesState,
    @Default(<Ad>[]) List<Ad> popularProductAds,
    @Default(LoadingState.loading) LoadingState popularProductAdsState,
    @Default(<Ad>[]) List<Ad> popularServiceAds,
    @Default(LoadingState.loading) LoadingState popularServiceAdsState,
    @Default(<Ad>[]) List<Ad> topRatedAds,
    @Default(LoadingState.loading) LoadingState topRatedAdsState,
    @Default(<Ad>[]) List<Ad> recentlyViewedAds,
    @Default(LoadingState.loading) LoadingState recentlyViewedAdsState,
    @Default(<BannerResponse>[]) List<BannerResponse> banners,
    @Default(LoadingState.loading) LoadingState bannersState,
    PagingController<int, Ad>? adsPagingController,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}

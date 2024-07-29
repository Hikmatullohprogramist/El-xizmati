part of 'dashboard_cubit.dart';

@freezed
class DashboardState with _$DashboardState {
  const DashboardState._();

  @freezed
  const factory DashboardState({
//
    @Default([]) List<PopularCategory> popularCategories,
    @Default(LoadingState.loading) LoadingState popularCategoriesState,
//
    @Default([]) List<Ad> popularProductAds,
    @Default(LoadingState.loading) LoadingState popularProductAdsState,
//
    @Default([]) List<Ad> popularServiceAds,
    @Default(LoadingState.loading) LoadingState popularServiceAdsState,
//
    @Default([]) List<Ad> topRatedAds,
    @Default(LoadingState.loading) LoadingState topRatedAdsState,
//
    @Default([]) List<Ad> installmentAds,
    @Default(LoadingState.loading) LoadingState installmentAdsState,
//
    @Default([]) List<Ad> recentlyViewedAds,
    @Default(LoadingState.loading) LoadingState recentlyViewedAdsState,
//
    @Default([]) List<BannerImage> banners,
    @Default(LoadingState.loading) LoadingState bannersState,
//
  }) = _DashboardState;

  bool get isRecentlyViewedAdsVisible =>
      recentlyViewedAdsState == LoadingState.loading ||
      (recentlyViewedAdsState == LoadingState.success &&
          recentlyViewedAds.isNotEmpty);
}

@freezed
class DashboardEvent with _$DashboardEvent {
  const factory DashboardEvent() = _DashboardEvent;
}

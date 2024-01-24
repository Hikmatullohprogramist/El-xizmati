part of 'dashboard_cubit.dart';

@freezed
class DashboardBuildable with _$DashboardBuildable {
  const DashboardBuildable._();

  @freezed
  const factory DashboardBuildable({
    @Default(<PopularCategoryResponse>[])
    List<PopularCategoryResponse> popularCategories,
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
  }) = _DashboardBuildable;
}

@freezed
class DashboardListenable with _$DashboardListenable {
  const factory DashboardListenable(DashboardEffect effect, {String? message}) =
      _DashboardListenable;
}

enum DashboardEffect { success, navigationToAuthStart }

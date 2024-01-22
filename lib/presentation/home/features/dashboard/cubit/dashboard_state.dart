part of 'dashboard_cubit.dart';

@freezed
class DashboardBuildable with _$DashboardBuildable {
  const DashboardBuildable._();

  @freezed
  const factory DashboardBuildable({
    @Default(<PopularCategoryResponse>[])
    List<PopularCategoryResponse> popularCategories,
    @Default(AppLoadingState.loading) AppLoadingState popularCategoriesState,
    @Default(<Ad>[]) List<Ad> popularProductAds,
    @Default(AppLoadingState.loading) AppLoadingState popularProductAdsState,
    @Default(<Ad>[]) List<Ad> popularServiceAds,
    @Default(AppLoadingState.loading) AppLoadingState popularServiceAdsState,
    @Default(<Ad>[]) List<Ad> topRatedAds,
    @Default(AppLoadingState.loading) AppLoadingState topRatedAdsState,
    @Default(<Ad>[]) List<Ad> recentlyViewedAds,
    @Default(AppLoadingState.loading) AppLoadingState recentlyViewedAdsState,
    @Default(<BannerResponse>[]) List<BannerResponse> banners,
    @Default(AppLoadingState.loading) AppLoadingState bannersState,
    PagingController<int, Ad>? adsPagingController,
  }) = _DashboardBuildable;
}

@freezed
class DashboardListenable with _$DashboardListenable {
  const factory DashboardListenable(DashboardEffect effect, {String? message}) =
      _DashboardListenable;
}

enum DashboardEffect { success, navigationToAuthStart }

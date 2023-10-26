part of 'dashboard_cubit.dart';

@freezed
class DashboardBuildable with _$DashboardBuildable {
  const DashboardBuildable._();

  const factory DashboardBuildable({
    @Default(AppLoadingState.loading) AppLoadingState popularCategoriesState,
    @Default(AppLoadingState.loading) AppLoadingState recentlyAdsState,
    @Default(AppLoadingState.loading) AppLoadingState bannersState,
    @Default(<PopularCategoryResponse>[]) List<PopularCategoryResponse> popularCategories,
    @Default(<AdResponse>[]) List<AdResponse> recentlyViewerAds,
    @Default(<BannerResponse>[]) List<BannerResponse> banners,
    @Default(<AdResponse>[]) List<AdResponse> adsList,
    PagingController<int, AdResponse>? adsPagingController,
  }) = _DashboardBuildable;
}

@freezed
class DashboardListenable with _$DashboardListenable {
  const factory DashboardListenable(DashboardEffect effect, {String? message}) =
      _DashboardListenable;
}

enum DashboardEffect { success }

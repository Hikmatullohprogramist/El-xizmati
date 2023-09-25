part of 'dashboard_cubit.dart';

@freezed
class DashboardBuildable with _$DashboardBuildable {
  const DashboardBuildable._();

  const factory DashboardBuildable({
    @Default(AppLoadingState.loading) AppLoadingState popularCategoriesState,
    @Default(AppLoadingState.loading) AppLoadingState recentlyAdsState,
    @Default(AppLoadingState.loading) AppLoadingState bannersState,
    @Default(<BannerResponse>[]) List<BannerResponse> banners,
    @Default(<AdsResponse>[]) List<AdsResponse> adsList,
    PagingController<int, AdsResponse>? adsPagingController,
  }) = _DashboardBuildable;
}

@freezed
class DashboardListenable with _$DashboardListenable {
  const factory DashboardListenable(DashboardEffect effect, {String? message}) =
      _DashboardListenable;
}

enum DashboardEffect { success }

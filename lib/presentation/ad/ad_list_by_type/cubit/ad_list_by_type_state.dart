part of 'ad_list_by_type_cubit.dart';

@freezed
class AdListByTypeBuildable with _$AdListByTypeBuildable {
  const factory AdListByTypeBuildable({
    @Default(AdType.product) AdType adType,
    @Default(LoadingState.loading) LoadingState cheapAdsState,
    @Default(LoadingState.loading) LoadingState popularAdsState,
    PagingController<int, Ad>? adsPagingController,
    @Default(<Ad>[]) List<Ad> cheapAds,
    @Default(<Ad>[]) List<Ad> popularAds,
  }) = _AdCollectionBuildable;
}

@freezed
class AdListByTypeListenable with _$AdListByTypeListenable {
  const factory AdListByTypeListenable(AdsListByTypeEffect effect,
      {String? message}) = _AdCollectionListenable;
}

enum AdsListByTypeEffect { success, navigationToAuthStart }

part of 'ad_collection_cubit.dart';

@freezed
class AdCollectionBuildable with _$AdCollectionBuildable {
  const factory AdCollectionBuildable({
    @Default(AppLoadingState.LOADING) AppLoadingState hotDiscountAdsState,
    @Default(AppLoadingState.LOADING) AppLoadingState popularAdsState,
    PagingController<int, AdResponse>? adsPagingController,
    @Default(<AdResponse>[]) List<AdResponse> hotDiscountAds,
    @Default(<AdResponse>[]) List<AdResponse> popularAds,
  }) = _AdCollectionBuildable;
}

@freezed
class AdCollectionListenable with _$AdCollectionListenable {
  const factory AdCollectionListenable(AdsCollectionEffect effect,
      {String? message}) = _AdCollectionListenable;
}

enum AdsCollectionEffect { success }

enum CollectiveType {
  commodity,
  service,
}

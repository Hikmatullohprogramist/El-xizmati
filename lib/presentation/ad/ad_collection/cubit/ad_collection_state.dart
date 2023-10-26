part of 'ad_collection_cubit.dart';

@freezed
class AdCollectionBuildable with _$AdCollectionBuildable {
  const factory AdCollectionBuildable({
    @Default(AppLoadingState.loading) AppLoadingState hotDiscountAdsState,
    @Default(AppLoadingState.loading) AppLoadingState popularAdsState,
    PagingController<int, AdModel>? adsPagingController,
    @Default(<AdModel>[]) List<AdModel> hotDiscountAds,
    @Default(<AdModel>[]) List<AdModel> popularAds,
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

part of 'ad_collection_cubit.dart';

@freezed
class AdCollectionBuildable with _$AdCollectionBuildable {
  const factory AdCollectionBuildable({
    @Default(CollectiveType.commodity) CollectiveType collectiveType,
    @Default(AppLoadingState.loading) AppLoadingState hotDiscountAdsState,
    @Default(AppLoadingState.loading) AppLoadingState popularAdsState,
    PagingController<int, Ad>? adsPagingController,
    @Default(<Ad>[]) List<Ad> hotDiscountAds,
    @Default(<Ad>[]) List<Ad> popularAds,
  }) = _AdCollectionBuildable;
}

@freezed
class AdCollectionListenable with _$AdCollectionListenable {
  const factory AdCollectionListenable(AdsCollectionEffect effect,
      {String? message}) = _AdCollectionListenable;
}

enum AdsCollectionEffect { success, navigationToAuthStart }

enum CollectiveType {
  commodity,
  service,
}

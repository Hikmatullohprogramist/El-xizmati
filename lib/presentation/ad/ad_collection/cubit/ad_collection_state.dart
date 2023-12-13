part of 'ad_collection_cubit.dart';

@freezed
class AdCollectionBuildable with _$AdCollectionBuildable {
  const factory AdCollectionBuildable({
    @Default(CollectiveType.product) CollectiveType collectiveType,
    @Default(AppLoadingState.loading) AppLoadingState cheapAdsState,
    @Default(AppLoadingState.loading) AppLoadingState popularAdsState,
    PagingController<int, Ad>? adsPagingController,
    @Default(<Ad>[]) List<Ad> cheapAds,
    @Default(<Ad>[]) List<Ad> popularAds,
  }) = _AdCollectionBuildable;
}

@freezed
class AdCollectionListenable with _$AdCollectionListenable {
  const factory AdCollectionListenable(AdsCollectionEffect effect,
      {String? message}) = _AdCollectionListenable;
}

enum AdsCollectionEffect { success, navigationToAuthStart }

enum CollectiveType { product, service }

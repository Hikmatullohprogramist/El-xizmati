part of 'ad_collection_cubit.dart';

@freezed
class AdCollectionBuildable with _$AdCollectionBuildable {
  const factory AdCollectionBuildable() = _AdCollectionBuildable;
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

part of 'ads_collection_cubit.dart';

@freezed
class AdsCollectionBuildable with _$AdsCollectionBuildable {
  const factory AdsCollectionBuildable() = _AdsCollectionBuildable;
}

@freezed
class AdsCollectionListenable with _$AdsCollectionListenable {
  const factory AdsCollectionListenable(AdsCollectionEffect effect,
      {String? message}) = _AdsCollectionListenable;
}

enum AdsCollectionEffect { success }

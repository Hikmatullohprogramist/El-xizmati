part of 'ads_list_cubit.dart';

@freezed
class AdsListBuildable with _$AdsListBuildable {
  const factory AdsListBuildable() = _AdsListBuildable;
}

@freezed
class AdsListListenable with _$AdsListListenable {
  const factory AdsListListenable(AdsListEffect effect, {String? message}) =
      _AdsListListenable;
}

enum AdsListEffect { success }

enum AdsListType{
  hotDiscount, recentlyViewer, popularCommodity
}

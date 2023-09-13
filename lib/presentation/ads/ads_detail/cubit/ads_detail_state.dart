part of 'ads_detail_cubit.dart';

@freezed
class AdsDetailBuildable with _$AdsDetailBuildable {
  const factory AdsDetailBuildable() = _AdsDetailBuildable;
}

@freezed
class AdsDetailListenable with _$AdsDetailListenable {
  const factory AdsDetailListenable(AdsDetailEffect effect, {String? message}) =
      _AdsDetailListenable;
}

enum AdsDetailEffect { success }

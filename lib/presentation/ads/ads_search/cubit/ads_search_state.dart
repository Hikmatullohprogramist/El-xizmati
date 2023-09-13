part of 'ads_search_cubit.dart';

@freezed
class AdsSearchBuildable with _$AdsSearchBuildable {
  const factory AdsSearchBuildable() = _AdsSearchBuildable;
}

@freezed
class AdsSearchListenable with _$AdsSearchListenable {
  const factory AdsSearchListenable(AdsSearchEffect effect, {String? message}) =
      _AdsSearchListenable;
}

enum AdsSearchEffect { success }

part of 'ad_search_cubit.dart';

@freezed
class AdSearchBuildable with _$AdSearchBuildable {
  const factory AdSearchBuildable() = _AdSearchBuildable;
}

@freezed
class AdSearchListenable with _$AdSearchListenable {
  const factory AdSearchListenable(AdSearchEffect effect, {String? message}) =
      _AdSearchListenable;
}

enum AdSearchEffect { success }

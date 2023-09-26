part of 'ad_list_cubit.dart';

@freezed
class AdListBuildable with _$AdListBuildable {
  const factory AdListBuildable() = _AdListBuildable;
}

@freezed
class AdListListenable with _$AdListListenable {
  const factory AdListListenable(AdListEffect effect, {String? message}) =
      _AdListListenable;
}

enum AdListEffect { success }

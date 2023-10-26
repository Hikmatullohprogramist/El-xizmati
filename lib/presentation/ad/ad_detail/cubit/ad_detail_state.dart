part of 'ad_detail_cubit.dart';

@freezed
class AdDetailBuildable with _$AdDetailBuildable {
  const factory AdDetailBuildable({int? adId}) = _AdDetailBuildable;
}

@freezed
class AdDetailListenable with _$AdDetailListenable {
  const factory AdDetailListenable(AdDetailEffect effect, {String? message}) =
      _AdDetailListenable;
}

enum AdDetailEffect {
  phoneCall,
  smsWrite,
}

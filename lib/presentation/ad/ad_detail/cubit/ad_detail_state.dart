part of 'ad_detail_cubit.dart';

@freezed
class AdDetailBuildable with _$AdDetailBuildable {
  const factory AdDetailBuildable({
    int? adId,
    AdDetail? adDetail,
    @Default(false) bool isAddCart,
    @Default(false) bool isPhoneVisible,
    @Default(<Ad>[]) List<Ad> similarAds,
    @Default(AppLoadingState.loading) AppLoadingState similarAdsState,
    @Default(<Ad>[]) List<Ad> recentlyViewedAds,
    @Default(AppLoadingState.loading) AppLoadingState recentlyViewedAdsState,
  }) = _AdDetailBuildable;
}

@freezed
class AdDetailListenable with _$AdDetailListenable {
  const factory AdDetailListenable(AdDetailEffect effect, {String? message}) =
      _AdDetailListenable;
}

enum AdDetailEffect { phoneCall, smsWrite }

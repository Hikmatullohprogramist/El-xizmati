part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    int? adId,
    AdDetail? adDetail,
    @Default(false) bool isAddCart,
    @Default(false) bool isPhoneVisible,
    @Default(<Ad>[]) List<Ad> similarAds,
    @Default(LoadingState.loading) LoadingState similarAdsState,
    @Default(<Ad>[]) List<Ad> ownerAds,
    @Default(LoadingState.loading) LoadingState ownerAdsState,
    @Default(<Ad>[]) List<Ad> recentlyViewedAds,
    @Default(LoadingState.loading) LoadingState recentlyViewedAdsState,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}

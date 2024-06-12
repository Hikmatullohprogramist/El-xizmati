part of 'ad_detail_cubit.dart';

@freezed
class AdDetailState with _$AdDetailState {
  const AdDetailState._();

  const factory AdDetailState({
    @Default(true) bool isNotPrepared,
    @Default(false) bool isPreparingInProcess,
//
    int? adId,
    AdDetail? adDetail,
//
    @Default(0) int visibleImageIndex,
//
    @Default(false) bool isAddCart,
    @Default(false) bool isPhoneVisible,
//
    @Default(<Ad>[]) List<Ad> similarAds,
    @Default(LoadingState.loading) LoadingState similarAdsState,
//
    @Default(<Ad>[]) List<Ad> ownerAds,
    @Default(LoadingState.loading) LoadingState ownerAdsState,
//
    @Default(<Ad>[]) List<Ad> recentlyViewedAds,
    @Default(LoadingState.loading) LoadingState recentlyViewedAdsState,
  }) = _AdDetailState;

  List<String> get images =>
      adDetail?.photos?.map((e) => e.image ?? "").toList() ?? [];

  int get imagesCount => adDetail?.photos?.length ?? 0;
}

@freezed
class AdDetailEvent with _$AdDetailEvent {
  const factory AdDetailEvent() = _AdDetailEvent;
}

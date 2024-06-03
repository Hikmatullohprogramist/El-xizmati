part of 'ad_list_by_type_cubit.dart';

@freezed
class AdListByTypeState with _$AdListByTypeState {
  const factory AdListByTypeState({
    @Default(AdType.product) AdType adType,
    @Default(LoadingState.loading) LoadingState cheapAdsState,
    @Default(LoadingState.loading) LoadingState popularAdsState,
    @Default(<Ad>[]) List<Ad> cheapAds,
    @Default(<Ad>[]) List<Ad> popularAds,
    PagingController<int, Ad>? controller,
  }) = _AdListByTypeState;
}

@freezed
class AdListByTypeEvent with _$AdListByTypeEvent {
  const factory AdListByTypeEvent() = _AdListByTypeEvent;
}

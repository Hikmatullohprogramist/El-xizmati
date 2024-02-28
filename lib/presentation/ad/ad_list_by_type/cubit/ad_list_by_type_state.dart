part of 'ad_list_by_type_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(AdType.product) AdType adType,
    @Default(LoadingState.loading) LoadingState cheapAdsState,
    @Default(LoadingState.loading) LoadingState popularAdsState,
    @Default(<Ad>[]) List<Ad> cheapAds,
    @Default(<Ad>[]) List<Ad> popularAds,
    PagingController<int, Ad>? controller,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}

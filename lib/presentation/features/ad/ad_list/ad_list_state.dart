part of 'ad_list_cubit.dart';

@freezed
class AdListState with _$AdListState {
  const factory AdListState({
    @Default("") String keyWord,
    @Default(AdListType.homePopularAds) AdListType adListType,
    @Default(LoadingState.loading) LoadingState adsState,
    PagingController<int, Ad>? controller,
    int? sellerTin,
    int? adId,
    AdType? collectiveType,
  }) = _AdListState;
}

@freezed
class AdListEvent with _$AdListEvent {
  const factory AdListEvent(AdListEventType type, {String? message}) = _AdListEvent;
}

enum AdListEventType { navigationToAuthStart }

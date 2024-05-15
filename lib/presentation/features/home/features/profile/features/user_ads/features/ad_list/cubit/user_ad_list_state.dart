part of 'user_ad_list_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default("") String keyWord,
    @Default(UserAdStatus.ALL) UserAdStatus userAdStatus,
    PagingController<int, UserAd>? controller,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}

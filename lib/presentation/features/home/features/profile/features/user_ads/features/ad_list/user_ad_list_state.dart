part of 'user_ad_list_cubit.dart';

@freezed
class UserAdListState with _$UserAdListState {
  const factory UserAdListState({
    @Default("") String keyWord,
    @Default(UserAdStatus.ALL) UserAdStatus userAdStatus,
    PagingController<int, UserAd>? controller,
  }) = _UserAdListState;
}

@freezed
class UserAdListEvent with _$UserAdListEvent {
  const factory UserAdListEvent() = _UserAdListEvent;
}

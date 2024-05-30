part of 'user_ad_detail_cubit.dart';

@freezed
class UserAdDetailState with _$UserAdDetailState {
  const factory UserAdDetailState(
      {UserAd? userAd,
      UserAdDetail? userAdDetail,
      @Default(LoadingState.loading) LoadingState loadState}) = _UserAdDetailState;
}

@freezed
class UserAdDetailEvent with _$UserAdDetailEvent {
  const factory UserAdDetailEvent() = _UserAdDetailEvent;
}

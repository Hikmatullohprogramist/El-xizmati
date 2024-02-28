part of 'user_ad_detail_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    UserAdResponse? userAdResponse,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}

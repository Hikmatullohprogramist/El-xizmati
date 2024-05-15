part of 'create_ad_chooser_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(false) bool isLogin,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}

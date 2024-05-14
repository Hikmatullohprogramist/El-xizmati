part of 'home_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(false) bool isLogin,
    @Default(0) int cartAdsCount,
    @Default(0) int favoriteAdsCount,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}

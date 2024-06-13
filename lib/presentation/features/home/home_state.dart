part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isAuthorized,
    @Default(0) int cartAdsCount,
    @Default(0) int favoriteAdsCount,
  }) = _HomeState;
}

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent() = _HomeEvent;
}

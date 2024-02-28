part of 'selection_unit_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(<UnitResponse>[]) List<UnitResponse> items,
    @Default(LoadingState.loading) LoadingState loadState,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}

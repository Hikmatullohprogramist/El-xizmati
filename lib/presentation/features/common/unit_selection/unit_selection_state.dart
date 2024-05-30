part of 'unit_selection_cubit.dart';

@freezed
class UnitSelectionState with _$UnitSelectionState {
  const factory UnitSelectionState({
    @Default(<UnitResponse>[]) List<UnitResponse> items,
    @Default(LoadingState.loading) LoadingState loadState,
  }) = _UnitSelectionState;
}

@freezed
class UnitSelectionEvent with _$UnitSelectionEvent {
  const factory UnitSelectionEvent() = _UnitSelectionEvent;
}

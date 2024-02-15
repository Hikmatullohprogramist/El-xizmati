part of 'selection_unit_cubit.dart';

@freezed
class SelectionUnitBuildable with _$SelectionUnitBuildable {
  const factory SelectionUnitBuildable({
    UnitResponse? selectedUnit,
    @Default(<UnitResponse>[]) List<UnitResponse> units,
    @Default(LoadingState.loading) LoadingState unitsState,
  }) = _SelectionUnitBuildable;
}

@freezed
class SelectionUnitListenable with _$SelectionUnitListenable {
  const factory SelectionUnitListenable(
    SelectionUnitEffect selectionUnitEffect, {
    UnitResponse? unitResponse,
  }) = _SelectionUnitListenable;
}

enum SelectionUnitEffect { back }

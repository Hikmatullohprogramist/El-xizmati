part of 'selection_unit_cubit.dart';

@freezed
class SelectionUnitBuildable with _$SelectionUnitBuildable {
  const factory SelectionUnitBuildable({
    @Default(<UnitResponse>[]) List<UnitResponse> items,
    @Default(LoadingState.loading) LoadingState itemsLoadState,
  }) = _SelectionUnitBuildable;
}

@freezed
class SelectionUnitListenable with _$SelectionUnitListenable {
  const factory SelectionUnitListenable() = _SelectionUnitListenable;
}
part of 'set_region_cubit.dart';

@freezed
class SetRegionState with _$SetRegionState {
  const SetRegionState._();

  const factory SetRegionState({
//
    @Default([]) List<ExpandableListItem> initialSelectedItems,
//
    @Default(LoadingState.loading) LoadingState loadState,
//
    @Default([]) List<ExpandableListItem> allItems,
    @Default([]) List<ExpandableListItem> visibleItems,
//
    int? regionId,
    String? regionName,
    int? districtId,
    String? districtName,
//
  }) = _SetRegionState;

  bool get isRegionSelected => regionId != null && districtId != null;
}

@freezed
class SetRegionEvent with _$SetRegionEvent {
  const factory SetRegionEvent(SetRegionEventType type) = _SetRegionEvent;
}

enum SetRegionEventType { onClose, onSave }

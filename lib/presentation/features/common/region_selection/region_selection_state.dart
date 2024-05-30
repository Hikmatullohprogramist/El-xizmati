part of 'region_selection_cubit.dart';

@freezed
class RegionSelectionState with _$RegionSelectionState {
  const factory RegionSelectionState({
    @Default([]) List<ExpandableListItem> initialSelectedItems,
    @Default(LoadingState.loading) LoadingState loadState,
    @Default([]) List<ExpandableListItem> allItems,
    @Default([]) List<ExpandableListItem> visibleItems,
    int? regionId,
    int? districtId,
  }) = _RegionSelectionState;
}

@freezed
class RegionSelectionEvent with _$RegionSelectionEvent {
  const factory RegionSelectionEvent() = _RegionSelectionEvent;
}

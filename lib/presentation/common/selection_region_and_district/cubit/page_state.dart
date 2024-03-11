part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default([]) List<ExpandableListItem> initialSelectedItems,
    @Default(LoadingState.loading) LoadingState loadState,
    @Default([]) List<ExpandableListItem> allItems,
    @Default([]) List<ExpandableListItem> visibleItems,
    int? regionId,
    int? districtId,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}

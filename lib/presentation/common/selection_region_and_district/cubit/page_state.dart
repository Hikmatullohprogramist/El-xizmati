part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default([]) List<RegionItem> initialSelectedItems,
    @Default(LoadingState.loading) LoadingState loadState,
    @Default([]) List<RegionItem> allItems,
    @Default([]) List<RegionItem> visibleItems,
    int? regionId,
    int? districtId,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}

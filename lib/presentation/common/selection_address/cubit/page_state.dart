part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(LoadingState.loading) LoadingState loadState,
    @Default([]) List<RegionResponse> items,
    @Default([]) List<RegionResponse> selectedItems,
    @Default([]) List<RegionResponse> regions,
    @Default([]) List<RegionResponse> districts,
    @Default([]) List<RegionResponse> streets,
    int? regionId,
    int? districtId,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}

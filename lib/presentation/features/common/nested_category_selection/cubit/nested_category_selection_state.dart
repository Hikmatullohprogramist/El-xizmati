part of 'nested_category_selection_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(AdType.PRODUCT) AdType adType,
    CategoryResponse? selectedItem,
    @Default([]) List<CategoryResponse> allItems,
    @Default([]) List<CategoryResponse> visibleItems,
    @Default(LoadingState.loading) LoadingState loadState,
    String? searchQuery,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(
    PageEventType type, {
    CategoryResponse? category,
  }) = _PageEvent;
}

enum PageEventType { closePage }

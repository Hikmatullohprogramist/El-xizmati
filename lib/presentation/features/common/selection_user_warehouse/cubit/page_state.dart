part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(<UserAddress>[]) List<UserAddress> items,
    @Default(LoadingState.loading) LoadingState loadState,
    @Default(<UserAddress>[]) List<UserAddress> selectedItems,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}

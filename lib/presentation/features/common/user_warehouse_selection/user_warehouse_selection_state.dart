part of 'user_warehouse_selection_cubit.dart';

@freezed
class UserWarehouseSelectionState with _$UserWarehouseSelectionState {
  const factory UserWarehouseSelectionState({
    @Default(<UserAddress>[]) List<UserAddress> items,
    @Default(LoadingState.loading) LoadingState loadState,
    @Default(<UserAddress>[]) List<UserAddress> selectedItems,
  }) = _UserWarehouseSelectionState;
}

@freezed
class UserWarehouseSelectionEvent with _$UserWarehouseSelectionEvent {
  const factory UserWarehouseSelectionEvent() = _UserWarehouseSelectionEvent;
}

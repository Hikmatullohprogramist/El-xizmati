part of 'selection_user_warehouse_cubit.dart';

@freezed
class SelectionUserWarehouseBuildable with _$SelectionUserWarehouseBuildable {
  const factory SelectionUserWarehouseBuildable({
    @Default(<UserAddressResponse>[]) List<UserAddressResponse> items,
    @Default(LoadingState.loading) LoadingState itemsLoadState,
    @Default(<UserAddressResponse>[]) List<UserAddressResponse> selectedItems,
  }) = _SelectionUserWarehouseBuildable;
}

@freezed
class SelectionUserWarehouseListenable with _$SelectionUserWarehouseListenable {
  const factory SelectionUserWarehouseListenable() =
      _SelectionUserWarehouseListenable;
}

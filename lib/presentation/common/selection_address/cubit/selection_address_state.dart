part of 'selection_address_cubit.dart';

@freezed
class SelectionAddressBuildable with _$SelectionAddressBuildable {
  const factory SelectionAddressBuildable({
    @Default(<RegionResponse>[]) List<RegionResponse> items,
    @Default(LoadingState.loading) LoadingState itemsLoadState,
    @Default(<RegionResponse>[]) List<RegionResponse> selectedItems,
    @Default(<RegionResponse>[]) List<RegionResponse> regions,
    @Default(<RegionResponse>[]) List<RegionResponse> districts,
    @Default(<RegionResponse>[]) List<RegionResponse> streets,

    int? regionId,
    int? districtId,

  }) = _SelectionAddressBuildable;
}

@freezed
class SelectionAddressListenable with _$SelectionAddressListenable {
  const factory SelectionAddressListenable() = _SelectionAddressListenable;
}

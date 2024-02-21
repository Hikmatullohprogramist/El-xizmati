part of 'selection_user_address_cubit.dart';

@freezed
class SelectionUserAddressBuildable with _$SelectionUserAddressBuildable {
  const factory SelectionUserAddressBuildable({
    @Default(<UserAddressResponse>[]) List<UserAddressResponse> items,
    @Default(LoadingState.loading) LoadingState itemsLoadState,
  }) = _SelectionUserAddressBuildable;
}

@freezed
class SelectionUserAddressListenable with _$SelectionUserAddressListenable {
  const factory SelectionUserAddressListenable() =
      _SelectionUserAddressListenable;
}

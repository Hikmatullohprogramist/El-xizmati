part of 'selection_user_address_cubit.dart';

@freezed
class SelectionUserAddressBuildable with _$SelectionUserAddressBuildable {
  const factory SelectionUserAddressBuildable(
          {@Default(<UserAddressResponse>[])
          List<UserAddressResponse> userAddresses,
          @Default(AppLoadingState.loading) AppLoadingState userAddressState}) =
      _SelectionUserAddressBuildable;
}

@freezed
class SelectionUserAddressListenable with _$SelectionUserAddressListenable {
  const factory SelectionUserAddressListenable(
          SelectionUserAddressEffect effect,
          {UserAddressResponse? userAddressResponse}) =
      _SelectionUserAddressListenable;
}

enum SelectionUserAddressEffect { back }

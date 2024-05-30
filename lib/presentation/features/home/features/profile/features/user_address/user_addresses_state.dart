part of 'user_addresses_cubit.dart';

@freezed
class UserAddressesState with _$UserAddressesState {
  const factory UserAddressesState({
    PagingController<int, UserAddress>? controller,
  }) = _UserAddressesState;
}

@freezed
class UserAddressesEvent with _$UserAddressesEvent {
  const factory UserAddressesEvent() = _UserAddressesEvent;
}

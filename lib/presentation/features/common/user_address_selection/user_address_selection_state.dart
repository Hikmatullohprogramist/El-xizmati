part of 'user_address_selection_cubit.dart';

@freezed
class UserAddressSelectionState with _$UserAddressSelectionState {
  const factory UserAddressSelectionState({
    @Default(<UserAddress>[]) List<UserAddress> items,
    @Default(LoadingState.loading) LoadingState loadState,
  }) = _UserAddressSelectionState;
}

@freezed
class UserAddressSelectionEvent with _$UserAddressSelectionEvent {
  const factory UserAddressSelectionEvent() = _UserAddressSelectionEvent;
}

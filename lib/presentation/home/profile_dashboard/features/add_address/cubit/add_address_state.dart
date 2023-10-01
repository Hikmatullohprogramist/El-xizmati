part of 'add_address_cubit.dart';

@freezed
class AddAddressBuildable with _$AddAddressBuildable {
  const factory AddAddressBuildable() = _AddAddressBuildable;
}

@freezed
class AddAddressListenable with _$AddAddressListenable {
  const factory AddAddressListenable(AddAddressEffect effect,
      {String? message}) = _AddAddressListenable;
}

enum AddAddressEffect { success }

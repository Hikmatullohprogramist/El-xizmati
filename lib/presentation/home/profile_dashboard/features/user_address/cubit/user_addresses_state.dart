part of 'user_addresses_cubit.dart';

@freezed
class UserAddressesBuildable with _$UserAddressesBuildable {
  const factory UserAddressesBuildable() = _UserAddressesBuildable;
}

@freezed
class UserAddressesListenable with _$UserAddressesListenable {
  const factory UserAddressesListenable(UserAddressesEffect effect,
      {String? error}) = _UserAddressesListenable;
}

enum UserAddressesEffect { success }

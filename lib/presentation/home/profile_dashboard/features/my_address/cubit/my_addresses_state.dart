part of 'my_addresses_cubit.dart';

@freezed
class MyAddressesBuildable with _$MyAddressesBuildable {
  const factory MyAddressesBuildable() = _MyAddressesBuildable;
}

@freezed
class MyAddressesListenable with _$MyAddressesListenable {
  const factory MyAddressesListenable(MyAddressesEffect effect,
      {String? error}) = _MyAddressesListenable;
}

enum MyAddressesEffect { success }

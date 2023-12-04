part of 'user_addresses_cubit.dart';

@freezed
class UserAddressesBuildable with _$UserAddressesBuildable {
  const factory UserAddressesBuildable({
    @Default("") String keyWord,
    @Default(AppLoadingState.loading) AppLoadingState adsState,
    PagingController<int, UserAddressResponse>? adsPagingController,
  }) = _UserAddressesBuildable;
}

@freezed
class UserAddressesListenable with _$UserAddressesListenable {
  const factory UserAddressesListenable(UserAddressesEffect effect,
      {String? error, UserAddressResponse? address}) = _UserAddressesListenable;
}

enum UserAddressesEffect { success, editUserAddress }

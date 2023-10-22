part of 'login_with_one_id_cubit.dart';

@freezed
class LoginWithOneIdBuildable with _$LoginWithOneIdBuildable {
  const factory LoginWithOneIdBuildable() = _LoginWithOneIdBuildable;
}

@freezed
class LoginWithOneIdListenable with _$LoginWithOneIdListenable {
  const factory LoginWithOneIdListenable(LoginWithOneIdEffect effect,{String? message}) = _LoginWithOneIdListenable;
}

enum LoginWithOneIdEffect { navigationHome }

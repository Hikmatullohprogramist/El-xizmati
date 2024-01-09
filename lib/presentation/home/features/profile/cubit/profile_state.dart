part of 'profile_cubit.dart';

@freezed
class ProfileBuildable with _$ProfileBuildable {
  const factory ProfileBuildable({
    @Default(false) bool isLogin,
    Language? language,
  }) = _ProfileBuildable;
}

@freezed
class ProfileListenable with _$ProfileListenable {
  const factory ProfileListenable(
    ProfileEffect effect, {
    String? message,
  }) = _ProfileListenable;
}

enum ProfileEffect { onLogOut }

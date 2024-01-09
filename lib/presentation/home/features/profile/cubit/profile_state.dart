part of 'profile_cubit.dart';

@freezed
class ProfileBuildable with _$ProfileDashboardBuildable {
  const factory ProfileBuildable({
    @Default(false) bool isLogin,
    Language? language,
  }) = _ProfileDashboardBuildable;
}

@freezed
class ProfileListenable with _$ProfileDashboardListenable {
  const factory ProfileListenable(
    ProfileDashboardEffect effect, {
    String? message,
  }) = _ProfileDashboardListenable;
}

enum ProfileDashboardEffect {
  success,
}

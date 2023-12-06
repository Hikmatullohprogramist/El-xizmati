part of 'profile_dashboard_cubit.dart';

@freezed
class ProfileDashboardBuildable with _$ProfileDashboardBuildable {
  const factory ProfileDashboardBuildable({@Default(false) bool isLogin}) =
      _ProfileDashboardBuildable;
}

@freezed
class ProfileDashboardListenable with _$ProfileDashboardListenable {
  const factory ProfileDashboardListenable(ProfileDashboardEffect effect,
      {String? message}) = _ProfileDashboardListenable;
}

enum ProfileDashboardEffect { success }

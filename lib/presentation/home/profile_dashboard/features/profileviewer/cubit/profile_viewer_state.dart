part of 'profile_viewer_cubit.dart';

@freezed
class ProfileViewerBuildable with _$ProfileViewerBuildable {
  const factory ProfileViewerBuildable() = _ProfileViewerBuildable;
}

@freezed
class ProfileViewerListenable with _$ProfileViewerListenable {
  const factory ProfileViewerListenable(ProfileViewerEffect effect,
      {String? message}) = _ProfileViewerListenable;
}

enum ProfileViewerEffect { success }

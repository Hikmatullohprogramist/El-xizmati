part of 'profile_edit_cubit.dart';

@freezed
class ProfileEditBuildable with _$ProfileEditBuildable {
  const factory ProfileEditBuildable() = _ProfileEditBuildable;
}

@freezed
class ProfileEditListenable with _$ProfileEditListenable {
  const factory ProfileEditListenable(ProfileEditEffect effect,
      {String? message}) = _ProfileEditListenable;
}

enum ProfileEditEffect { success }

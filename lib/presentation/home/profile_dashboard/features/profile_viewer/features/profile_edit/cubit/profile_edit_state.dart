part of 'profile_edit_cubit.dart';

@freezed
class ProfileEditBuildable with _$ProfileEditBuildable {
  const factory ProfileEditBuildable({
    @Default("") String biometricSerial,
    @Default("") String biometricNumber,
    @Default("") String brithDate,
    @Default("") String phoneNumber,
    @Default("") String fullName, 
    @Default("") String userName, 
    @Default("") String email, 
    @Default("") String region, 
    @Default("") String district, 
    @Default("") String neighborhood,
    @Default("") String homeNumber, 
    @Default("") String apartmentNumber
}) = _ProfileEditBuildable;
}

@freezed
class ProfileEditListenable with _$ProfileEditListenable {
  const factory ProfileEditListenable(ProfileEditEffect effect,
      {String? message}) = _ProfileEditListenable;
}

enum ProfileEditEffect { success }

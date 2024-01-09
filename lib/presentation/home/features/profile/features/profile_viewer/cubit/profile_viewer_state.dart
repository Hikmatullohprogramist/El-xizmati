part of 'profile_viewer_cubit.dart';

@freezed
class ProfileViewerBuildable with _$ProfileViewerBuildable {
  const factory ProfileViewerBuildable({
    @Default(false) bool isRegistration,
    @Default(false) bool isLoading,
    @Default("*") String userName,
    @Default("*") String fullName,
    @Default("*") String brithDate,
    @Default("*") String biometricInformation,
    @Default("*") String email,
    @Default("*") String phoneNumber,
    @Default("*") String regionName,
    @Default("*") String districtName,
    @Default("*") String streetName,
    @Default("*") String gender,
    @Default("*") String photo,
    int? regionId,
    int? districtId,
    int? streetId,
  }) = _ProfileViewerBuildable;
}

@freezed
class ProfileViewerListenable with _$ProfileViewerListenable {
  const factory ProfileViewerListenable(ProfileViewerEffect effect,
      {String? message}) = _ProfileViewerListenable;
}

enum ProfileViewerEffect { success, navigationAuthStart}

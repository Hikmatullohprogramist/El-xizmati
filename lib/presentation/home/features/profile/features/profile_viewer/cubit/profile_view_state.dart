part of 'profile_view_cubit.dart';

@freezed
class ProfileViewerBuildable with _$ProfileViewerBuildable {
  const factory ProfileViewerBuildable({
    @Default(false) bool isRegistered,
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
class ProfileViewListenable with _$ProfileViewerListenable {
  const factory ProfileViewListenable(ProfileViewEffect effect,
      {String? message}) = _ProfileViewerListenable;
}

enum ProfileViewEffect {
  // onLoadingUserInfo, onSuccessUserInfo, onFailureUserInfo,

  navigationAuthStart
}

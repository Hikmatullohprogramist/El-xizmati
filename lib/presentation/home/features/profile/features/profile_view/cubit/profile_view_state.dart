part of 'profile_view_cubit.dart';

@freezed
class ProfileViewBuildable with _$ProfileViewBuildable {
  const factory ProfileViewBuildable({
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
    @Default(false) bool smsNotification,
    @Default(false) bool telegramNotification,
    @Default(false) bool emailNotification,
    PagingController<int, ActiveDeviceResponse>? devicesPagingController,
  }) = _ProfileViewerBuildable;
}

@freezed
class ProfileViewListenable with _$ProfileViewListenable {
  const factory ProfileViewListenable(ProfileViewEffect effect,
      {String? message}) = _ProfileViewerListenable;
}

enum ProfileViewEffect { navigationAuthStart }

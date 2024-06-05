part of 'profile_view_cubit.dart';

@freezed
class ProfileViewState with _$ProfileViewState {
  const factory ProfileViewState({
    @Default(false) bool isRegistered,
//
    @Default(false) bool isUserLoading,
    @Default(false) bool isUserDataLoaded,
//
    @Default("*") String userName,
    @Default("*") String fullName,
    @Default("*") String brithDate,
    @Default("*") String biometricInformation,
    @Default("*") String email,
    @Default("*") String phoneNumber,
    @Default("*") String regionName,
    @Default("*") String districtName,
    @Default("*") String neighborhoodName,
    @Default("*") String gender,
    @Default("*") String photo,
    int? regionId,
    int? districtId,
    int? streetId,
//
    @Default(false) bool savedSmsState,
    @Default(false) bool savedTelegramState,
    @Default(false) bool savedEmailState,
//
    @Default(false) bool actualSmsState,
    @Default(false) bool actualTelegramState,
    @Default(false) bool actualEmailState,
    @Default(false) bool isUpdatingNotification,
//
    SocialAccountInfo? instagramInfo,
    SocialAccountInfo? telegramInfo,
    SocialAccountInfo? facebookInfo,
    SocialAccountInfo? youtubeInfo,
//
    @Default("") String instagram,
    @Default("") String telegram,
    @Default("") String facebook,
    @Default("") String youtube,
    @Default(false) bool isUpdatingSocialInfo,
//
    @Default([]) List<Region> regions,
    @Default([]) List<District> districts,
    @Default([]) List<Neighborhood> neighborhoods,
//
    PagingController<int, ActiveSession>? controller,
  }) = _ProfileViewState;
}

@freezed
class ProfileViewEvent with _$ProfileViewEvent {
  const factory ProfileViewEvent(ProfileViewEventType type) = _ProfileViewEvent;
}

enum ProfileViewEventType { onLogout }

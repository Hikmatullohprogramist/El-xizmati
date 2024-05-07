part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(false) bool isRegistered,
//
    @Default(false) bool isLoading,
//
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
    PagingController<int, ActiveSession>? controller,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType type) = _PageEvent;
}

enum PageEventType {
  onLogout,
  onSuccessUpdateNotification,
  onFailedUpdateNotification,
  onSuccessUpdateSocial,
  onFailedUpdateSocial,
}

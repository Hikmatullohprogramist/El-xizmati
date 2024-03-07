part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
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
    @Default(false) bool isLoadingNotification,


    @Default("https://www.instagram.com/") String instagram,
    @Default("https://t.me/") String telegram,
    @Default("https://www.facebook.com/") String facebook,
    @Default("https://www.youtube.com/") String youtube,

    @Default(<bool>[false,false,false]) List<bool> enableButton,

    @Default(<Social>[]) List<Social> instagramSocial,
    @Default(<Social>[]) List<Social> telegramSocial,
    @Default(<Social>[]) List<Social> facebookSocial,
    @Default(<Social>[]) List<Social> youtubeSocial,

    PagingController<int, ActiveSession>? controller,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType type) = _PageEvent;
}

enum PageEventType { onLogout }

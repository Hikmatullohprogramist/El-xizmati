part of 'registration_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default("") String docSerial,
    @Default("") String docNumber,
    @Default("") String brithDate,
    //
    @Default("") String phoneNumber,
    @Default("") String fullName,
    @Default("") String userName,
    @Default("") String email,
    //
    @Default("") String regionName,
    @Default("") String districtName,
    @Default("") String neighborhoodName,
    @Default("") String homeNumber,
    @Default("") String apartmentNumber,
    //
    @Default([]) List<Region> regions,
    @Default([]) List<District> districts,
    @Default([]) List<Neighborhood> neighborhoods,
    //
    @Default(false) bool isLoading,
    //
    String? gender,
    int? id,
    int? tin,
    int? pinfl,
    int? regionId,
    int? districtId,
    int? neighborhoodId,
    String? postName,
    String? mobileNumber,
    //
    @Default(false) bool isRegistration,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType type) = _PageEvent;
}

enum PageEventType {
  success,
  rejected,
  notFound,
}

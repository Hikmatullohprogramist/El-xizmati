part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(false) bool isLoading,
    @Default("") String biometricSerial,
    @Default("") String biometricNumber,
    @Default("") String brithDate,
    @Default("") String phoneNumber,
    @Default("") String fullName,
    @Default("") String userName,
    @Default("") String email,
    @Default("") String regionName,
    @Default("") String districtName,
    @Default("") String neighborhoodName,
    @Default("") String homeNumber,
    @Default([]) List<Region> regions,
    @Default([]) List<District> districts,
    @Default([]) List<Neighborhood> neighborhoods,
    int? regionId,
    int? districtId,
    int? neighborhoodId,
    String? gender,
    int? id,
    int? tin,
    int? pinfl,
    String? postName,
    String? mobileNumber,
    String? photo,
    @Default("") String apartmentNumber,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}

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
    @Default("") String streetName,
    @Default("") String homeNumber,
    @Default(<RegionResponse>[]) List<RegionResponse> regions,
    @Default(<RegionResponse>[]) List<RegionResponse> districts,
    @Default(<RegionResponse>[]) List<RegionResponse> streets,
    int? regionId,
    int? districtId,
    int? streetId,
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

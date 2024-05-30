part of 'profile_edit_cubit.dart';

@freezed
class ProfileEditState with _$ProfileEditState {
  const factory ProfileEditState({
    @Default(false) bool isLoading,
    @Default("") String docSerial,
    @Default("") String docNumber,
    @Default("") String birthDate,
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
  }) = _ProfileEditState;
}

@freezed
class ProfileEditEvent with _$ProfileEditEvent {
  const factory ProfileEditEvent() = _ProfileEditEvent;
}

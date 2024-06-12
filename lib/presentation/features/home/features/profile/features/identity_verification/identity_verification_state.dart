part of 'identity_verification_cubit.dart';

@freezed
class IdentityVerificationState with _$IdentityVerificationState {
  const factory IdentityVerificationState({
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
    @Default("") String houseNumber,
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
    @Default(false) bool isIdentityVerified,
  }) = _IdentityVerificationState;
}

@freezed
class IdentityVerificationEvent with _$IdentityVerificationEvent {
  const factory IdentityVerificationEvent(IdentityVerificationEventType type) =
      _IdentityVerificationEvent;
}

enum IdentityVerificationEventType {
  success,
  rejected,
  notFound,
}

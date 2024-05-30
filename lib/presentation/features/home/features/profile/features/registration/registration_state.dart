part of 'registration_cubit.dart';

@freezed
class RegistrationState with _$RegistrationState {
  const factory RegistrationState({
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
  }) = _RegistrationState;
}

@freezed
class RegistrationEvent with _$RegistrationEvent {
  const factory RegistrationEvent(RegistrationEventType type) =
      _RegistrationEvent;
}

enum RegistrationEventType {
  success,
  rejected,
  notFound,
}

part of 'registration_cubit.dart';

@freezed
class RegistrationBuildable with _$RegistrationBuildable {
  const factory RegistrationBuildable(
      {@Default("") String biometricSerial,
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
      @Default("") String apartmentNumber,
      @Default(<RegionResponse>[]) List<RegionResponse> regions,
      @Default(<RegionResponse>[]) List<RegionResponse> districts,
      @Default(<RegionResponse>[]) List<RegionResponse> streets,
      @Default(false) bool isLoading,
      String? gender,
      int? id,
      int? tin,
      int? pinfl,
      int? regionId,
      int? districtId,
      int? streetId,
      String? postName,
      String? mobileNumber,
      @Default(false) bool isRegistration}) = _RegistrationBuildable;
}

@freezed
class RegistrationListenable with _$RegistrationListenable {
  const factory RegistrationListenable(RegistrationEffect effect,
      {String? message}) = _RegistrationListenable;
}

enum RegistrationEffect { success, backToProfileDashboard }

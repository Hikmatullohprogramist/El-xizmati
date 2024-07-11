part of 'registration_cubit.dart';

@freezed
class RegistrationState with _$RegistrationState {
  const factory RegistrationState({
//
    @Default("") String docSeries,
    @Default("") String docNumber,
    @Default("") String brithDate,
//
    @Default("") String phoneNumber,
//
    @Default("") String password,
    @Default("") String confirm,
//
    @Default(false) bool isLoading,
//
    @Default("") String sessionToken,
  }) = _RegistrationState;
}

@freezed
class RegistrationEvent with _$RegistrationEvent {
  const factory RegistrationEvent(RegistrationEventType type) = _RegistrationEvent;
}

enum RegistrationEventType { onOpenOtpConfirm }

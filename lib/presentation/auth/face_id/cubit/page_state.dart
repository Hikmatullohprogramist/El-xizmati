part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(true) bool isFaceIdByPinflEnabled,
    @Default(false) bool isAllDataValid,
    @Default(false) bool isRequestInProcess,
    @Default("dd.mm.yyyy") String birthDate,
    @Default("") String bioDocSerial,
    @Default("") String bioDocNumber,
    @Default("") String pinfl,
    @Default("") String secretKey,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType type) = _PageEvent;
}

enum PageEventType {
  onVerificationSuccess,
  onPinflNotFound,
  onBioDocNotFound
}

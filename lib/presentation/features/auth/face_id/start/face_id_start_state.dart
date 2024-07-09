part of 'face_id_start_cubit.dart';

@freezed
class FaceIdStartState with _$FaceIdStartState {
  const factory FaceIdStartState({
//
    @Default(true) bool isFaceIdByPinflEnabled,
//
    @Default(false) bool isAllDataValid,
    @Default(false) bool isRequestInProcess,
//
    @Default("dd.mm.yyyy") String birthDate,
    @Default("") String docSeries,
    @Default("") String docNumber,
    @Default("") String pinfl,
//
    @Default("") String secretKey,
//
  }) = _FaceIdStartState;
}

@freezed
class FaceIdStartEvent with _$FaceIdStartEvent {
  const factory FaceIdStartEvent(FaceIdStartEventType type) =
      _FaceIdStartEvent;
}

enum FaceIdStartEventType {
  onVerificationSuccess,
  onPinflNotFound,
  onBioDocNotFound
}

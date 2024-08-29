part of 'add_picture_cubit.dart';

@freezed
class AddPictureState with _$AddPictureState {
  const AddPictureState._();

  const factory AddPictureState({
    @Default(null) UploadableFile? image,
  }) = _AddPictureState;
}

@freezed
class AddPictureEvent with _$AddPictureEvent {
  const factory AddPictureEvent(AddPictureEventType type) = _AddPictureEvent;
}

enum AddPictureEventType { onSetImage }

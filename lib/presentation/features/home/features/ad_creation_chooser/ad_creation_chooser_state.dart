part of 'ad_creation_chooser_cubit.dart';

@freezed
class AdCreationChooserState with _$AdCreationChooserState {
  const factory AdCreationChooserState({
    @Default(false) bool isAuthorized,
  }) = _AdCreationChooserState;
}

@freezed
class AdCreationChooserEvent with _$AdCreationChooserEvent {
  const factory AdCreationChooserEvent() = _AdCreationChooserEvent;
}

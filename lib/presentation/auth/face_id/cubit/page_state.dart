
part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(false) bool loading,
    @Default(false) bool nextState,
    @Default(false) bool enablePinflButton,
    @Default(false) bool enableSeriaButton,
    @Default("dd.MM.yyyy") String birthDate,


    @Default("") String passportSeries,
    @Default("") String passportNumber,
    @Default("") String passportPinfl,
    @Default("") String secretKey,

}) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType type) = _PageEvent;
}
enum PageEventType { verification, error,errorPinfl }

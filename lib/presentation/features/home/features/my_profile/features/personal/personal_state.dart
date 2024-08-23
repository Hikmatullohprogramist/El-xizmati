part of 'personal_cubit.dart';

@freezed
class PersonalState with _$PersonalState{
  const PersonalState._();

  const factory PersonalState({
    @Default("") String name,
    @Default("") String surname,
    @Default("") String docSeries,
    @Default("") String docNumber,
    @Default("") String phoneNumber,
    @Default("") String regionName,
    @Default("") String districtName,

}) = _PersonalState;

}
@freezed
class PersonalEvent with _$PersonalEvent{
  const factory PersonalEvent() = _PersonalEvent;
}
part of 'ad_creation_result_cubit.dart';

@freezed
class AdCreationResultState with _$AdCreationResultState {
  const factory AdCreationResultState({
    @Default(0) int adId,
    @Default(AdTransactionType.sell) AdTransactionType adTransactionType,
  }) = _AdCreationResultState;
}

@freezed
class AdCreationResultEvent with _$AdCreationResultEvent {
  const factory AdCreationResultEvent() = _AdCreationResultEvent;
}

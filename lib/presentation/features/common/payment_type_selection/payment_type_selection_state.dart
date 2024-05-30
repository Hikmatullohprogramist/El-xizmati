part of 'payment_type_selection_cubit.dart';

@freezed
class PaymentTypeSelectionState with _$PaymentTypeSelectionState {
  const factory PaymentTypeSelectionState({
    @Default([]) List<PaymentTypeResponse> items,
    @Default([]) List<PaymentTypeResponse> selectedItems,
    @Default(LoadingState.loading) LoadingState loadState,
  }) = _PaymentTypeSelectionState;
}

@freezed
class PaymentTypeSelectionEvent with _$PaymentTypeSelectionEvent {
  const factory PaymentTypeSelectionEvent() = _PaymentTypeSelectionEvent;
}

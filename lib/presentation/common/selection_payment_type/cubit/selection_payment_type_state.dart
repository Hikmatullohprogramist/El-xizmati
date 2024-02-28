part of 'selection_payment_type_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default([]) List<PaymentTypeResponse> items,
    @Default([]) List<PaymentTypeResponse> selectedItems,
    @Default(LoadingState.loading) LoadingState loadState,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}

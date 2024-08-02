part of 'installment_info_cubit.dart';

@freezed
class InstallmentInfoState with _$InstallmentInfoState {
  const factory InstallmentInfoState({
    UserOrderSmartResponse? userOrder,
     ///
    AdDetail? productDetail,
    @Default(<UserOrderSmartDetailResponse>[]) List<UserOrderSmartDetailResponse> detailItems,
    @Default(<SmPlanPayment>[]) List<SmPlanPayment> planPayments,
    @Default(<SmPlanPayment>[]) List<SmPlanPayment> constPlanPayments,
    SmPlanPayment? currentSelectionMonth,
    SmPlanPayment? constCurrentSelectionMonth,
    @Default("") String startPrice,
    @Default("") String startDate,
    DateTime? startDay,
    @Default(true) bool enableStartPrice,
    @Default(LoadingState.loading) LoadingState detailItemsState,
    @Default(0) num overallSumma,
    @Default(0) int selectionItem,
    @Default(0) num selectionItemStartPrice,
    ///
    @Default(1) int productCount,
    ///
    @Default(false) bool orderCreationState,
    @Default(LoadingState.loading) LoadingState emptyPlanPaymentState,
    ///
  }) = _InstallmentInfoEventState;
}

@freezed
class InstallmentInfoEvent with _$InstallmentInfoEvent {
  const factory InstallmentInfoEvent(InstallmentInfoEventEventType type) = _InstallmentInfoEventEvent;
}
enum InstallmentInfoEventEventType { onBackAfterRemove, onOpenAfterCreation, onOpenAuthStart, onFailure }

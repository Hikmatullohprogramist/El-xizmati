import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/repositories/billing_repository.dart';
import 'package:onlinebozor/domain/models/billing/billing_transaction.dart';
import 'package:onlinebozor/domain/models/billing/billing_transaction_filter.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'billing_transaction_filter_cubit.freezed.dart';
part 'billing_transaction_filter_state.dart';

@Injectable()
class BillingTransactionFilterCubit extends BaseCubit<
    BillingTransactionFilterState, BillingTransactionFilterEvent> {
  final BillingRepository _paymentTransactionRepository;

  BillingTransactionFilterCubit(
    this._paymentTransactionRepository,
  ) : super(const BillingTransactionFilterState()) {
    paymentTypes();
    paymentMethods();
    transactionStates();
    getTransactionList();
  }

  void getTransactionList() async {
    try {
      final response =
          await _paymentTransactionRepository.getPaymentTransactionsFilter();
      logger.d(response.toString());
      updateState((state) => state.copyWith(transactions: response));
    } catch (e, stackTrace) {}
  }

  void fromDate(String fromDate) {
    updateState((state) => state.copyWith(fromDate: fromDate));
  }

  void toDate(String toDate) {
    updateState((state) => state.copyWith(toDate: toDate));
  }

  void setPaymentType(String paymentType) {
    updateState((state) => state.copyWith(paymentType: paymentType));
  }

  void setPaymentMethod(String paymentMethod) {
    updateState((state) => state.copyWith(paymentMethod: paymentMethod));
  }

  void setTransactionStates(String transactionStates) {
    updateState((state) => state.copyWith(transactionState: transactionStates));
  }

  void paymentTypes() {
    final List<BillingTransactionFilter> items = [
      BillingTransactionFilter(name: "Reklama", isSelected: false),
      BillingTransactionFilter(name: "Hamyon", isSelected: false),
    ];
    updateState((state) => state.copyWith(paymentTypes: items));
  }

  void paymentMethods() {
    final List<BillingTransactionFilter> items = [
      BillingTransactionFilter(name: "Hamyon", isSelected: false),
      BillingTransactionFilter(name: "Realpay", isSelected: false),
    ];
    updateState((state) => state.copyWith(paymentMethods: items));
  }

  void transactionStates() {
    final List<BillingTransactionFilter> items = [
      BillingTransactionFilter(name: "To'landi", isSelected: false),
      BillingTransactionFilter(name: "To'lanmadi", isSelected: false),
    ];
    updateState((state) => state.copyWith(transactionStates: items));
  }

  void clearAllFilter() {
    paymentTypes();
    paymentMethods();
    transactionStates();
    updateState((state) => state.copyWith(
        fromDate: "",
        toDate: "",
        paymentType: "",
        paymentMethod: "",
        transactionState: ""));
  }
}

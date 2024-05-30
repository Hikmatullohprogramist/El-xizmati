import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/network/responses/transaction/payment_transaction_response.dart';
import 'package:onlinebozor/data/repositories/payment_repository.dart';
import 'package:onlinebozor/domain/models/payment_filter/paymant_filter.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'payment_transaction_filter_cubit.freezed.dart';
part 'payment_transaction_filter_state.dart';

@Injectable()
class PaymentTransactionFilterCubit extends BaseCubit<
    PaymentTransactionFilterState, PaymentTransactionFilterEvent> {
  final PaymentRepository _paymentTransactionRepository;

  PaymentTransactionFilterCubit(
    this._paymentTransactionRepository,
  ) : super(const PaymentTransactionFilterState()) {
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
    final List<PaymentFilter> items = [
      PaymentFilter(name: "Reklama", isSelected: false),
      PaymentFilter(name: "Hamyon", isSelected: false),
    ];
    updateState((state) => state.copyWith(paymentTypes: items));
  }

  void paymentMethods() {
    final List<PaymentFilter> items = [
      PaymentFilter(name: "Hamyon", isSelected: false),
      PaymentFilter(name: "Realpay", isSelected: false),
    ];
    updateState((state) => state.copyWith(paymentMethods: items));
  }

  void transactionStates() {
    final List<PaymentFilter> items = [
      PaymentFilter(name: "To'landi", isSelected: false),
      PaymentFilter(name: "To'lanmadi", isSelected: false),
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

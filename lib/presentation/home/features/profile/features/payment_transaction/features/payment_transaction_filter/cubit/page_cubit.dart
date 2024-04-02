import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../common/core/base_cubit.dart';
import '../../../../../../../../../data/repositories/transaction_repository.dart';
import '../../../../../../../../../data/responses/favorite/favorite_response.dart';
import '../../../../../../../../../data/responses/transaction/payment_transaction_response.dart';
import '../../../../../../../../../domain/models/payment_filter/paymant_filter.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.paymentTransactionRepository) : super(const PageState()) {
    paymentTypes();
    paymentMethods();
    transactionStates();
    getTransactionList();
  }

  final PaymentTransactionRepository paymentTransactionRepository;

  void getTransactionList() async {
    try {
      final response =
          await paymentTransactionRepository.getPaymentTransactionsFilter();
      log.d(response.toString());
      updateState((state) => state.copyWith(transactionList: response));
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

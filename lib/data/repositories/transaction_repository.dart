import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/network/responses/transaction/payment_transaction_response.dart';
import 'package:onlinebozor/data/datasource/network/services/payment_transaction_service.dart';

@LazySingleton()
class PaymentTransactionRepository {
  final PaymentTransactionService _service;

  PaymentTransactionRepository(this._service);

  Future<List<dynamic>> getPaymentTransactions({
    required int pageSize,
    required pageIndex,
  }) async {
    final root = await _service.getTransactions(pageIndex, pageSize);
    final response = PaymentTransactionRootResponse.fromJson(root.data).data;
    return response.results;
  }

  Future<List<PaymentTransaction>>
      getPaymentTransactionsFilter() async {
    final root = await _service.getPaymentTransactionFilter();
    final response = PaymentTransactionRootResponse.fromJson(root.data).data;
    return response.results;
  }
}

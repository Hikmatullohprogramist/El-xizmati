import 'package:onlinebozor/data/datasource/network/responses/transaction/payment_transaction_response.dart';
import 'package:onlinebozor/data/datasource/network/services/payment_service.dart';
import 'package:onlinebozor/data/datasource/preference/auth_preferences.dart';
import 'package:onlinebozor/data/error/app_locale_exception.dart';
import 'package:onlinebozor/data/mappers/billing_mapper.dart';
import 'package:onlinebozor/domain/models/billing/billing_transaction.dart';

class PaymentRepository {
  final AuthPreferences _authPreferences;
  final PaymentService _paymentService;

  PaymentRepository(
    this._authPreferences,
    this._paymentService,
  );

  Future<List<BillingTransaction>> getPaymentTransactions({
    required int pageSize,
    required pageIndex,
  }) async {
    if (_authPreferences.isNotAuthorized) throw NotAuthorizedException();
    // if (_userPreferences.isNotIdentified) throw NotIdentifiedException();

    final root = await _paymentService.getTransactions(
      pageIndex,
      pageSize,
    );
    final response = PaymentTransactionRootResponse.fromJson(root.data).data;
    return response.results.map((e) => e.toTransaction()).toList();
  }

  Future<List<BillingTransaction>> getPaymentTransactionsFilter() async {
    final root = await _paymentService.getPaymentTransactionFilter();
    final response = PaymentTransactionRootResponse.fromJson(root.data).data;
    return response.results.map((e) => e.toTransaction()).toList();
  }
}

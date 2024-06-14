import 'package:collection/collection.dart';
import 'package:onlinebozor/data/datasource/network/responses/billing/billing_transaction_response.dart';
import 'package:onlinebozor/data/datasource/network/services/payment_service.dart';
import 'package:onlinebozor/data/datasource/preference/auth_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/user_preferences.dart';
import 'package:onlinebozor/data/error/app_locale_exception.dart';
import 'package:onlinebozor/data/mappers/billing_mapper.dart';
import 'package:onlinebozor/domain/models/billing/billing_transaction.dart';

class BillingRepository {
  final AuthPreferences _authPreferences;
  final PaymentService _paymentService;
  final UserPreferences _userPreferences;

  BillingRepository(
    this._authPreferences,
    this._paymentService,
    this._userPreferences,
  );

  Future<List<BillingTransaction>> getPaymentTransactions({
    required int pageSize,
    required pageIndex,
  }) async {
    if (_authPreferences.isNotAuthorized) throw NotAuthorizedException();
    if (_userPreferences.isNotIdentified) throw NotIdentifiedException();

    final root = await _paymentService.getTransactions(
      pageIndex,
      pageSize,
    );
    final response = BillingTransactionRootResponse.fromJson(root.data).data;
    return response.results.mapIndexed((i, e) => e.toTransaction(i)).toList();
  }

  Future<List<BillingTransaction>> getPaymentTransactionsFilter() async {
    final root = await _paymentService.getPaymentTransactionFilter();
    final response = BillingTransactionRootResponse.fromJson(root.data).data;
    return response.results.map((e) => e.toTransaction(0)).toList();
  }
}

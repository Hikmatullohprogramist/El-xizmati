import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/network/responses/transaction/payment_transaction_response.dart';
import 'package:onlinebozor/data/datasource/network/services/payment_transaction_service.dart';
import 'package:onlinebozor/data/error/app_locale_exception.dart';
import 'package:onlinebozor/data/repositories/state_repository.dart';
import 'package:onlinebozor/data/repositories/user_repository.dart';

@LazySingleton()
class PaymentTransactionRepository {
  PaymentTransactionRepository(
    this._paymentTransactionService,
    this._stateRepository,
    this._userRepository,
  );

  final PaymentTransactionService _paymentTransactionService;
  final StateRepository _stateRepository;
  final UserRepository _userRepository;

  Future<List<dynamic>> getPaymentTransactions({
    required int pageSize,
    required pageIndex,
  }) async {
    if (_stateRepository.isNotAuthorized()) throw NotAuthorizedException();
    if (_userRepository.isNotIdentified()) throw NotIdentifiedException();

    final root = await _paymentTransactionService.getTransactions(
      pageIndex,
      pageSize,
    );
    final response = PaymentTransactionRootResponse.fromJson(root.data).data;
    return response.results;
  }

  Future<List<PaymentTransaction>> getPaymentTransactionsFilter() async {
    final root = await _paymentTransactionService.getPaymentTransactionFilter();
    final response = PaymentTransactionRootResponse.fromJson(root.data).data;
    return response.results;
  }
}

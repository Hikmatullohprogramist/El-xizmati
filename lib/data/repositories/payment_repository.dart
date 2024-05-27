import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/hive/storages/language_storage.dart';
import 'package:onlinebozor/data/datasource/hive/storages/user_storage.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_constants.dart';
import 'package:onlinebozor/data/datasource/network/extensions/rest_mappers.dart';
import 'package:onlinebozor/data/datasource/network/responses/realpay/real_pay_merchant_token_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/transaction/payment_transaction_response.dart';
import 'package:onlinebozor/data/datasource/network/services/payment_service.dart';
import 'package:onlinebozor/data/error/app_locale_exception.dart';
import 'package:onlinebozor/data/repositories/state_repository.dart';
import 'package:onlinebozor/data/repositories/user_repository.dart';

@LazySingleton()
class PaymentRepository {
  PaymentRepository(
    this._languageStorage,
    this._paymentService,
    this._stateRepository,
    this._userRepository,
    this._userStorage,
  );

  final LanguageStorage _languageStorage;
  final PaymentService _paymentService;
  final StateRepository _stateRepository;
  final UserRepository _userRepository;
  final UserStorage _userStorage;

  Future<List<dynamic>> getPaymentTransactions({
    required int pageSize,
    required pageIndex,
  }) async {
    if (_stateRepository.isNotAuthorized()) throw NotAuthorizedException();
    if (_userRepository.isNotIdentified()) throw NotIdentifiedException();

    final root = await _paymentService.getTransactions(
      pageIndex,
      pageSize,
    );
    final response = PaymentTransactionRootResponse.fromJson(root.data).data;
    return response.results;
  }

  Future<List<PaymentTransaction>> getPaymentTransactionsFilter() async {
    final root = await _paymentService.getPaymentTransactionFilter();
    final response = PaymentTransactionRootResponse.fromJson(root.data).data;
    return response.results;
  }

  Future<RealPayMerchantToken?> getPaymentMerchantToken() async {
    final root = await _paymentService.getPaymentMerchantToken(
      _userStorage.pinflOrTin,
      RestConstants.REAL_PAY_REDIRECT_URI,
    );
    final response = RealPayMerchantTokenRootResponse.fromJson(root.data).data;
    return response;
  }

  String generatePaymentUrl(String merchantToken) {
    var language = _languageStorage.language.getRestCode();
    return "https://payment.realpay.uz/?token=$merchantToken&lang=$language";
  }
}

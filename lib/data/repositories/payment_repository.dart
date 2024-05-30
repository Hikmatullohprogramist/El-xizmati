import 'package:onlinebozor/data/datasource/network/constants/rest_constants.dart';
import 'package:onlinebozor/data/datasource/network/extensions/rest_mappers.dart';
import 'package:onlinebozor/data/datasource/network/responses/realpay/real_pay_merchant_token_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/transaction/payment_transaction_response.dart';
import 'package:onlinebozor/data/datasource/network/services/payment_service.dart';
import 'package:onlinebozor/data/datasource/preference/language_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/token_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/user_preferences.dart';
import 'package:onlinebozor/data/error/app_locale_exception.dart';

// @LazySingleton()
class PaymentRepository {
  final LanguagePreferences _languagePreferences;
  final PaymentService _paymentService;
  final TokenPreferences _tokenPreferences;
  final UserPreferences _userPreferences;

  PaymentRepository(
    this._languagePreferences,
    this._paymentService,
    this._tokenPreferences,
    this._userPreferences,
  );

  Future<List<dynamic>> getPaymentTransactions({
    required int pageSize,
    required pageIndex,
  }) async {
    if (_tokenPreferences.isNotAuthorized) throw NotAuthorizedException();
    if (_userPreferences.isNotIdentified) throw NotIdentifiedException();

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
      _userPreferences.tinOrPinfl,
      RestConstants.REAL_PAY_REDIRECT_URI,
    );
    final response = RealPayMerchantTokenRootResponse.fromJson(root.data).data;
    return response;
  }

  String generatePaymentUrl(String merchantToken) {
    var language = _languagePreferences.language.getRestCode();
    return "https://payment.realpay.uz/?token=$merchantToken&lang=$language";
  }
}

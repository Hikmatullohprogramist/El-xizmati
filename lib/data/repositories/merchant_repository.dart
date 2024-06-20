import 'package:onlinebozor/data/datasource/network/constants/rest_constants.dart';
import 'package:onlinebozor/data/datasource/network/extensions/rest_mappers.dart';
import 'package:onlinebozor/data/datasource/network/responses/realpay/real_pay_merchant_token_response.dart';
import 'package:onlinebozor/data/datasource/network/services/private/card_service.dart';
import 'package:onlinebozor/data/datasource/network/services/private/payment_service.dart';
import 'package:onlinebozor/data/datasource/preference/language_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/user_preferences.dart';

class MerchantRepository {
  final CardService _cardService;
  final LanguagePreferences _languagePreferences;
  final PaymentService _paymentService;
  final UserPreferences _userPreferences;

  MerchantRepository(
    this._cardService,
    this._languagePreferences,
    this._paymentService,
    this._userPreferences,
  );

  Future<RealPayMerchantToken?> getRealPayAddCardMerchantToken() async {
    final root = await _cardService.getAddCardMerchantToken(
      _userPreferences.tinOrPinfl,
      RestConstants.REAL_PAY_REDIRECT_URI,
    );
    final response = RealPayMerchantTokenRootResponse.fromJson(root.data).data;
    return response;
  }

  String generateAddCardUrl(String merchantToken) {
    var language = _languagePreferences.language.getRestCode();
    return "https://payment.realpay.uz/?token=$merchantToken&lang=$language";
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

import 'package:onlinebozor/data/datasource/network/constants/rest_constants.dart';
import 'package:onlinebozor/data/datasource/network/extensions/rest_mappers.dart';
import 'package:onlinebozor/data/datasource/network/responses/balance/user_deposit_balance_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/realpay/real_pay_card_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/realpay/real_pay_merchant_token_response.dart';
import 'package:onlinebozor/data/datasource/network/services/card_service.dart';
import 'package:onlinebozor/data/datasource/preference/language_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/token_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/user_preferences.dart';
import 'package:onlinebozor/data/error/app_locale_exception.dart';

// @LazySingleton()
class CardRepository {
  final CardService _cardService;
  final LanguagePreferences _languagePreferences;
  final TokenPreferences _tokenPreferences;
  final UserPreferences _userPreferences;

  CardRepository(
    this._cardService,
    this._languagePreferences,
    this._tokenPreferences,
    this._userPreferences,
  );

  Future<UserDepositBalance> getDepositCardBalance() async {
    if (_tokenPreferences.isNotAuthorized) throw NotAuthorizedException();
    if (_userPreferences.isNotIdentified) throw NotIdentifiedException();

    final root = await _cardService.getDepositCardBalance();
    final response = UserDepositBalanceRootResponse.fromJson(root.data).data;
    return response;
  }

  Future<RealPayMerchantToken?> getRealPayAddCardMerchantToken() async {
    final root = await _cardService.getAddCardMerchantToken(
      _userPreferences.tinOrPinfl,
      RestConstants.REAL_PAY_REDIRECT_URI,
    );
    final response = RealPayMerchantTokenRootResponse.fromJson(root.data).data;
    return response;
  }

  Future<List<RealPayCard>> getAddedCards() async {
    final root = await _cardService.getAddedCards();
    final response = RealPayCardRootResponse.fromJson(root.data).data.data;
    return response;
  }

  Future<void> removeCard(String cardId) async {
    final pinflOrTin = _userPreferences.tinOrPinfl;
    final root = await _cardService.removeCard(cardId, pinflOrTin);
    return;
  }

  String generateAddCardUrl(String merchantToken) {
    var language = _languagePreferences.language.getRestCode();
    return "https://payment.realpay.uz/?token=$merchantToken&lang=$language";
  }
}

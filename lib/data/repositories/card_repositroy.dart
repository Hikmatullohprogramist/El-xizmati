import 'package:onlinebozor/data/datasource/network/responses/balance/user_deposit_balance_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/realpay/real_pay_card_response.dart';
import 'package:onlinebozor/data/datasource/network/services/card_service.dart';
import 'package:onlinebozor/data/datasource/preference/auth_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/user_preferences.dart';
import 'package:onlinebozor/data/error/app_locale_exception.dart';

class CardRepository {
  final AuthPreferences _authPreferences;
  final CardService _cardService;
  final UserPreferences _userPreferences;

  CardRepository(
    this._authPreferences,
    this._cardService,
    this._userPreferences,
  );

  Future<UserDepositBalance> getDepositCardBalance() async {
    if (_authPreferences.isNotAuthorized) throw NotAuthorizedException();
    if (_userPreferences.isNotIdentified) throw NotIdentifiedException();

    final root = await _cardService.getDepositCardBalance();
    final response = UserDepositBalanceRootResponse.fromJson(root.data).data;
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
}

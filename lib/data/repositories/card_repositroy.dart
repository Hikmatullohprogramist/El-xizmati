import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/network/responses/balance/user_deposit_balance_response.dart';
import 'package:onlinebozor/data/datasource/network/services/card_service.dart';

@LazySingleton()
class CardRepository {
  final CardService _cardService;

  CardRepository(this._cardService);

  Future<UserDepositBalance> getDepositBalance() async {
    final root = await _cardService.getDepositBalance();
    final response = UserDepositBalanceRootResponse.fromJson(root.data).data;
    return response;
  }
}

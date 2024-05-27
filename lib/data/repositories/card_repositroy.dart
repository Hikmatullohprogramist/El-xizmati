import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/network/responses/balance/user_deposit_balance_response.dart';
import 'package:onlinebozor/data/datasource/network/services/card_service.dart';
import 'package:onlinebozor/data/error/app_locale_exception.dart';
import 'package:onlinebozor/data/repositories/state_repository.dart';
import 'package:onlinebozor/data/repositories/user_repository.dart';

@LazySingleton()
class CardRepository {
  final CardService _cardService;
  final StateRepository _stateRepository;
  final UserRepository _userRepository;

  CardRepository(
    this._cardService,
    this._stateRepository,
    this._userRepository,
  );

  Future<UserDepositBalance> getDepositBalance() async {
    if (_stateRepository.isNotAuthorized()) throw NotAuthorizedException();
    if (_userRepository.isNotIdentified()) throw NotIdentifiedException();

    final root = await _cardService.getDepositBalance();
    final response = UserDepositBalanceRootResponse.fromJson(root.data).data;
    return response;
  }
}

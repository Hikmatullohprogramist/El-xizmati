import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/hive/storages/language_storage.dart';
import 'package:onlinebozor/data/datasource/hive/storages/user_storage.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_constants.dart';
import 'package:onlinebozor/data/datasource/network/extensions/rest_mappers.dart';
import 'package:onlinebozor/data/datasource/network/responses/realpay/real_pay_card_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/realpay/real_pay_merchant_token_response.dart';
import 'package:onlinebozor/data/datasource/network/services/real_pay_integration_service.dart';

@LazySingleton()
class RealPayIntegrationRepository {
  RealPayIntegrationRepository(
    this._languageStorage,
    this._realPayIntegrationService,
    this._userStorage,
  );

  final LanguageStorage _languageStorage;
  final RealPayIntegrationService _realPayIntegrationService;
  final UserStorage _userStorage;

  Future<List<RealPayCard>> getAddedCards() async {
    final root = await _realPayIntegrationService.getAddedCards();
    final response = RealPayCardRootResponse.fromJson(root.data).data.data;
    return response;
  }

  Future<RealPayMerchantToken?> getPaymentMerchantToken() async {
    final root = await _realPayIntegrationService.getPaymentMerchantToken(
      _userStorage.pinflOrTin,
      RestConstants.REAL_PAY_REDIRECT_URI,
    );
    final response = RealPayMerchantTokenRootResponse.fromJson(root.data).data;
    return response;
  }

  Future<RealPayMerchantToken?> getRealPayAddCardMerchantToken() async {
    final root = await _realPayIntegrationService.getAddCardMerchantToken(
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

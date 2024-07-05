import 'package:dio/dio.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_constants.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_query_keys.dart';

class CardService {
  CardService(this._dio);

  final Dio _dio;

  Future<Response> getDepositCardBalance() async {
    return _dio.get("api/v1/user/balance");
  }

  Future<Response> getUserDebitCards() async {
    return _dio.get("api/realpay/v1/card/user-card/get-all");
  }

  Future<Response> getAddCardMerchantToken(int tin, String redirectUrl) async {
    final params = {
      RestQueryKeys.tin: tin,
      RestQueryKeys.customerType: RestConstants.REAL_PAY_TYPE_ADD_CART,
      RestQueryKeys.redirectUrl: redirectUrl,
    };

    return _dio.post("api/realpay/v1/add-card", queryParameters: params);
  }

  Future<Response> removeCard(String cardId, int tin) async {
    final body = {RestQueryKeys.cardId: cardId, RestQueryKeys.tin: tin};
    return _dio.delete("api/realpay/v1/card/remove", data: body);
  }
}

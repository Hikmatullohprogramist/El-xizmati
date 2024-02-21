import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../constants/rest_query_keys.dart';
import '../storages/token_storage.dart';

@lazySingleton
class AdCreationService {
  final Dio _dio;
  final TokenStorage tokenStorage;

  AdCreationService(this._dio, this.tokenStorage);

  Future<Response> getCategoriesForCreationAd() {
    return _dio.get('v1/get-categories-for-create-ad');
  }

  Future<Response> getCurrenciesForCreationAd() {
    return _dio.get('v1/get-currencies-for-create-ad');
  }

  Future<Response> getDeliveryTypesForCreationAd() {
    return _dio.get('v1/get-delivery-types-for-create-ad');
  }

  Future<Response> getPaymentTypesForCreationAd() {
    return _dio.get('v1/get-payment-types-for-create-ad');
  }

  Future<Response> getWarehousesForCreationAd() {
    return _dio.get('v1/get-warehouses-for-create-ad');
  }

  Future<Response> getUnitsForCreationAd() {
    return _dio.get('v1/get-untis-for-create-ad');
  }

  Future<Response> createProductAd({
    required String phone,
    required String code,
    required String sessionToken,
  }) {
    final body = {
      RestQueryKeys.phoneNumber: phone,
      RestQueryKeys.sessionToken: sessionToken,
      RestQueryKeys.securityCode: code
    };
    return _dio.post('v1/user-create-ad', data: body);
  }

//
// {
// "name": "Iphone 11",
// "category_id": 10,
// "main_photo": "fdgbthadaefe",
// "photos": [
// "aghthyhjyjh",
// "fgnsrhjyjtrshrt"
// ],
// "description": "Juda zo'r smartfon",
// "price": 6000000,
// "currency": "SUM",
// "is_contract": true,
// "route_type": "PRIVATE",
// "property_status": "NEW",
// "contact_name": "test@example.com",
// "phone_number": "998999999999",
// "is_auto_renew": false,
// "type_status": "SELL",
// "other_name": "Iphone 12 pro",
// "other_category_id": 10,
// "other_description": "Sifati yaxshi bo'lsin",
// "other_route_type": "PRIVATE",
// "other_property_status": "USED",
// "from_price": 0,
// "to_price": 0,
// "payment_types": [
// "1",
// "3"
// ],
// "show_social": false,
// "has_shipping": false,
// "has_free_shipping": false,
// "main_type_status": "SELL",
// "unit_id": 2,
// "amount": 10,
// "sale_type": "PRODUCT",
// "video": "youtube.com",
// "min_amount": 1,
// "delivery_types": [
// "2",
// "3"
// ],
// "has_discount": false,
// "service_category_id": null,
// "service_sub_category_id": null,
// "has_bidding": true
// }
}

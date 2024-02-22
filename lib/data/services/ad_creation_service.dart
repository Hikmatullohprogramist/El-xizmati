import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/utils/dio_extensions.dart';

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
    required String title,
    required int categoryId,
    required pickedImageIds,
    required String desc,
    required int? warehouseCount,
    required int? unitId,
    required int? price,
    required String? currency,
    required List<String>? paymentTypeIds,
    required bool isAgreedPrice,
    required bool isNew,
    required bool isBusiness,
    required int? addressId,
    required String contactPerson,
    required String phone,
    required String email,
    required bool isAutoRenewal,
    required bool isShowMySocialAccount,
  }) {
    final body = {
      "name": title,
      "category_id": categoryId,
      // "main_photo": "",
      // "photos": ["", ""],
      "description": desc,
      "price": price,
      "currency": currency,
      "is_contract": isAgreedPrice,
      "route_type": isBusiness ? "BUSINESS" : "PRIVATE",
      "property_status": isNew ? "NEW" : "USED",
      "contact_person": contactPerson,
      "contact_name": email,
      "phone_number": phone,
      "is_auto_renew": isAutoRenewal,
      "type_status": "SELL",
      // "other_name": "Iphone 12 pro",
      // "other_category_id": 10,
      // "other_description": "Sifati yaxshi bo'lsin",
      // "other_route_type": "PRIVATE",
      // "other_property_status": "USED",
      // "from_price": 0,
      // "to_price": 0,
      "payment_types": paymentTypeIds,
      "show_social": isShowMySocialAccount,
      "has_shipping": false,
      "has_free_shipping": false,
      "main_type_status": "SELL", // todo use actual data
      "unit_id": unitId,
      "amount": warehouseCount,
      "sale_type": "PRODUCT", // todo use actual data ADS, PRODUCT, SERVICE
      "video": "", // todo use actual data
      "min_amount": 1, // todo use actual data
      "delivery_types": ["2", "3"], // todo use actual data
      "has_discount": false,
      // "service_category_id": null,
      // "service_sub_category_id": null,
      "has_bidding": isAgreedPrice
    };

    Dio dioCabinet = _dio.cloneWithCabinetBaseUrl();
    return dioCabinet.post('api/mobile/v1/user-create-ad', data: body);
    // return dioCabinet.post('api/v1/mobile/ads', data: body);
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

  // Name  ===  Type  ===  Info
  // name  ===  String  ===  *Mahsulot yoki xizmat nomi
  // category_id  ===  Long  ===  *Tanlangan kategoriya idsi
  // main_photo  ===  String  ===  *Kiritgan rasmlardan birinchisi
  // photos  ===  Array of Strings  ===  *Kiritgan rasmlardan qolgani
  // description  ===  String  ===  Mahsulot yoki xizmat tavsifi
  // price  ===  Long  ===  *Mahsulot narxi (faqat mahsulot uchun)
  // currency  ===  String  ===  Valyuta
  // is_contract  ===  Boolean  ===  Kelishish bor yoki yo’qligi
  // route_type  ===  String  ===  *PRIVATE yoki BUSINESS
  // property_status  ===  String  ===  *NEW yoki USED
  // email  ===  String  ===  User email
  // phone_numberString  ===  User telefon raqami
  // is_auto_renew  ===  Boolean  ===  Avto uzaytirish
  // type_status  ===  String  ===  *SELL, FREE, EXCHANGE, SERVICE, BUY, BUY_SERVICE
  // end_date  ===  Timestamp  ===  *Hozirgi vaqtdan bir oy keyin
  // region_id  ===  Long  ===  *Region
  // district_id  ===  Long  ===  *District
  // other_name  ===  String  ===  Almashadigan mahsulot nomi
  // other_category_id  ===  Long  ===  Almashadigan mahsulot kategoriyasi
  // other_description  ===  String  ===  Almashadigan mahsulot tavsifi
  // other_route_type  ===  String  ===  PRIVATE or BUSINESS
  // other_property_status  ===  String  ===  NEW or USED
  // tin  ===  Long  ===  *User tin
  // from_price  ===  Long  ===  *Xizmat narxi dan (faqat xizmat uchun)
  // to_price  ===  Long  ===  *Xizmat narxi gacha (faqat xizmat uchun)
  // payment_types  ===  Array of ids  ===  *To’lov turlari
  // show_social  ===  Boolean  ===  Sotsial setga ruhsat berish
  // main_type_status  ===  String  ===  SELL or BUY
  // unit_id  ===  Integer   ===  Birlik (mahsulotda required, xizmatda optional)
  // amount  ===  Long  ===  *Mahsulot miqdori (faqat mahsulot uchun)
  // sale_type  ===  String  ===  ADS, PRODUCT, SERVICE
  // video  ===  String  ===  Video uchun havola
  // file  ===  String  ===  Sertifikat kiritish
  // min_amount  ===  Long  ===  *Mahsulot eng kam sotish miqdori (faqat mahsulot uchun)
  // delivery_types  ===  Array of ids  ===  *Yetkazib berish turlari (faqat mahsulot uchun)
  // has_discount  ===  Boolean  ===  Chegirma bor yoki yo’qligi
  // service_category_id  ===  Integer  ===  *Xizmat kategoriyasi (faqat xizmat uchun)
  // service_sub_category_id  ===  Integer  ===  *Xizmat sub kategoriyasi (faqat xizmat uchun)
  // has_bidding  ===  Boolean  ===  Kelishiladimi
  // name_ru  ===  String  ===  Mahsulot yoki xizmat nomi rus tilida
  // description_ru  ===  String  ===  Mahsulot yoki xizmat tavsifi rus tilida
  // send_to_russian_website  ===  Boolean  ===  Hamkor saytda ma’lumotlar chiqishiga rozilik bildirish

}

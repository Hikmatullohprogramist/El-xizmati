import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/utils/rest_mappers.dart';
import 'package:onlinebozor/domain/models/ad/ad_transaction_type.dart';

import '../../domain/models/ad/ad_type.dart';
import '../storages/token_storage.dart';

@lazySingleton
class AdCreationService {
  final Dio dio;
  final TokenStorage tokenStorage;

  AdCreationService(this.dio, this.tokenStorage);

  Future<Response> getCategoriesForCreationAd(String type) {
    final Map<String, dynamic> query = {"type": type};
    return dio.get(
      'api/mobile/v1/get-categories-for-create-ad',
      queryParameters: query,
    );
  }

  Future<Response> getCurrenciesForCreationAd() {
    return dio.get('api/mobile/v1/get-currencies-for-create-ad');
  }

  Future<Response> getDeliveryTypesForCreationAd() {
    return dio.get('api/mobile/v1/get-delivery-types-for-create-ad');
  }

  Future<Response> getPaymentTypesForCreationAd() {
    return dio.get('api/mobile/v1/get-payment-types-for-create-ad');
  }

  Future<Response> getWarehousesForCreationAd({required int tinOrPinfl}) {
    final Map<String, dynamic> query = {};
    query["org_id"] = tinOrPinfl;
    return dio.get(
      'api/mobile/v1/get-warehouses-for-create-ad',
      queryParameters: query,
    );
  }

  Future<Response> getUnitsForCreationAd() {
    return dio.get('api/mobile/v1/get-untis-for-create-ad');
  }

  Future<Response> uploadImage(XFile xFile) async {
    var formData = FormData.fromMap({
      'form_element_id': 2588,
      'form_element_project_id': 34,
      'file': await MultipartFile.fromFile(xFile.path, filename: xFile.name),
    });

    return await dio.post(
      'https://online-bozor.uz/files/upload/category/ads',
      data: formData,
    );
  }

  Future<Response> createProductAd({
    required String title,
    required int categoryId,
    required AdTransactionType adTransactionType,
    //
    required String mainImageId,
    required List<String> pickedImageIds,
    //
    required String desc,
    required int? warehouseCount,
    required int? unitId,
    required int minAmount,
    required int? price,
    required String? currency,
    required List<String>? paymentTypeIds,
    required bool isAgreedPrice,
    //
    required String propertyStatus,
    required String accountType,
    //
    required String exchangeTitle,
    required String exchangeDesc,
    required int? exchangeCategoryId,
    required String exchangePropertyStatus,
    required String exchangeAccountType,
    //
    required int? addressId,
    required String contactPerson,
    required String phone,
    required String email,
    //
    required bool isPickupEnabled,
    required List<int> pickupWarehouses,
    required bool isFreeDeliveryEnabled,
    required int freeDeliveryMaxDay,
    required List<int> freeDeliveryDistricts,
    required bool isPaidDeliveryEnabled,
    required int paidDeliveryMaxDay,
    required int? paidDeliveryPrice,
    required List<int> paidDeliveryDistricts,
    //
    required bool isAutoRenewal,
    required bool isShowMySocialAccount,
    required String videoUrl,
  }) {
    Map<String, Object?> commonBody = {
      "name": title,
      "category_id": categoryId,
      "type_status": adTransactionType.name,
      //
      "main_photo": mainImageId,
      "photos": pickedImageIds,

      "description": desc,
      "contact_name": contactPerson,
      "email": email,
      "phone_number": phone,

      "route_type": accountType,
      "property_status": propertyStatus,

      "show_social": isShowMySocialAccount,
      "has_shipping": isPaidDeliveryEnabled,
      "has_free_shipping": isFreeDeliveryEnabled,
      "main_type_status": AdTransactionType.SELL.name, // will be constant

      "sale_type": AdType.product.name.toUpperCase(),
      "video": videoUrl,
      "min_amount": minAmount,

      "is_pickup_enabled": isPickupEnabled,
      "is_free_delivery_enabled": isFreeDeliveryEnabled,
      "is_paid_delivery_enabled": isPaidDeliveryEnabled,

      "is_auto_renew": isAutoRenewal,
    };

    if (isPickupEnabled) {
      final pickupBody = {
        "pickup_address_ids": pickupWarehouses.toMapList("warehouse_id"),
      };
      commonBody.addAll(pickupBody);
    }

    if (isFreeDeliveryEnabled) {
      final freeDeliveryBody = {
        "free_delivery_district_ids":
            freeDeliveryDistricts.toMapList("district_id"),
        "free_delivery_max_days": freeDeliveryMaxDay,
      };
      commonBody.addAll(freeDeliveryBody);
    }

    if (isPaidDeliveryEnabled) {
      final paidDeliveryBody = {
        "paid_delivery_district_ids":
            paidDeliveryDistricts.toMapList("district_id"),
        "paid_delivery_max_days": paidDeliveryMaxDay,
        "shipping_price": paidDeliveryPrice,
        "shipping_unit_id": 12, // km unit id 12
      };
      commonBody.addAll(paidDeliveryBody);
    }

    if (adTransactionType != AdTransactionType.FREE) {
      final notFreeBody = {
        "price": price,
        "currency": currency,
        "is_contract": isAgreedPrice,
        "unit_id": unitId,
        "amount": warehouseCount,
        "payment_types": paymentTypeIds,
        "has_discount": false,
        "has_bidding": isAgreedPrice
      };
      commonBody.addAll(notFreeBody);
    }

    if (adTransactionType == AdTransactionType.EXCHANGE) {
      final exchangeBody = {
        "other_name": exchangeTitle,
        "other_category_id": exchangeCategoryId!,
        "other_description": exchangeDesc,
        "other_route_type": exchangeAccountType,
        "other_property_status": exchangePropertyStatus,
      };
      commonBody.addAll(exchangeBody);
    }

    return dio.post(
      'api/mobile/v1/create-ad',
      data: commonBody,
    );
  }

  Future<Response> createServiceAd({
    required String title,
    required int categoryId,
    required int serviceCategoryId,
    required int serviceSubCategoryId,
    //
    required String mainImageId,
    required List<String> pickedImageIds,
    required String desc,
    //
    required int fromPrice,
    required int toPrice,
    required String currency,
    required List<String> paymentTypeIds,
    required bool isAgreedPrice,
    //
    required String accountType,
    required List<int> serviceDistricts,
    //
    required int addressId,
    required String contactPerson,
    required String phone,
    required String email,
    //
    required bool isAutoRenewal,
    required bool isShowMySocialAccount,
    required String videoUrl,
  }) {
    Map<String, Object?> commonBody = {
      "name": title,
      "category_id": categoryId,
      "service_category_id": serviceCategoryId,
      "service_sub_category_id": serviceSubCategoryId,
      //
      "main_photo": mainImageId,
      "photos": pickedImageIds.map((e) => e).toList(),

      "description": desc,
      "contact_name": contactPerson,
      "email": email,
      "phone_number": phone,

      "from_price": fromPrice,
      "to_price": toPrice,
      "currency": currency,
      "is_contract": isAgreedPrice,
      "payment_types": paymentTypeIds,
      "has_discount": false,
      "has_bidding": isAgreedPrice,

      "route_type": accountType,
      "delivery_types": serviceDistricts.toMapList("district_id"),

      "type_status": AdTransactionType.SERVICE.name,
      "main_type_status": AdTransactionType.SELL.name,
      "sale_type": AdType.service.name.toUpperCase(),

      "is_auto_renew": isAutoRenewal,
      "show_social": isShowMySocialAccount,
      "video": videoUrl
    };

    return dio.post(
      'api/mobile/v1/create-ad',
      data: commonBody,
    );
  }

// { XIZMAT SOTAMAN SO'ROVI
//   "name": "Test Xizmat bor",
//   "category_id": 1262,
//   "main_photo": "ff8081818278445ed39fb9ea",
//   "photos": [
//   "ff8081818278445ed39fb9ea",
//   "ff80818144013d02d3f1ba01"
//   ],
//   "description": "test",
//   "price": 0,
//   "currency": "860",
//   "is_contract": true,
//   "route_type": "PRIVATE",
//   "property_status": "NEW",
//   "email": "abror.esonaliyev@gmail.com",
//   "phone_number": "998977521770",
//   "type_status": "SERVICE",
//   "is_auto_renew": true,
//   "to_price": 25000,
//   "from_price": 12343,
//   "video": null,
//   "address_id": 6047,
//   "show_social": true,
//   "is_work_share": true,
//   "delivery_types": [
//   {
//   "district_id": 2603,
//   "type": "SERVICE_RADIUS"
//   }
//   ],
//   "payment_types": [1,6 ],
//   "values": []
// }

  Future<Response> createRequestAd({
    required String title,
    required int categoryId,
    required AdType adType,
    required AdTransactionType adTransactionType,
    //
    required String mainImageId,
    required List<String> pickedImageIds,
    required String desc,
    //
    required int fromPrice,
    required int toPrice,
    required String currency,
    required List<String> paymentTypeIds,
    required bool isAgreedPrice,
    //
    required List<int> requestDistricts,
    //
    required int addressId,
    required String contactPerson,
    required String phone,
    required String email,
    //
    required bool isAutoRenewal,
  }) {
    Map<String, Object?> commonBody = {
      "name": title,
      "category_id": categoryId,
      //
      "main_photo": mainImageId,
      "photos": pickedImageIds.map((e) => e).toList(),

      "description": desc,
      "contact_name": contactPerson,
      "email": email,
      "phone_number": phone,

      "from_price": fromPrice,
      "to_price": toPrice,
      "currency": currency,
      "is_contract": isAgreedPrice,
      "payment_types": paymentTypeIds,
      "has_discount": false,
      "has_bidding": isAgreedPrice,

      "property_status": "NEW", // fixme remove this field
      "min_amount": 1, // fixme remove this field
      "delivery_types": requestDistricts.toMapList("district_id"),

      "type_status": adTransactionType.name,
      "main_type_status": adTransactionType.name,
      "sale_type": adType.name.toUpperCase(),

      "is_auto_renew": isAutoRenewal,
    };

    return dio.post(
      'api/mobile/v1/create-ad',
      data: commonBody,
    );
  }

// { XIZMAT KERAK SO'ROVI
//   "name": "Test Xizmat Kerak",
//   "category_id": 2044,
//   "main_photo": "ff80818195c5ffeed4081213",
//   "photos": [
//   "ff80818195c5ffeed4081213",
//   "ff808181fedd036cd3dc9933",
//   "ff8081816db902e7d43f7d6d"
//   ],
//   "description": "test",
//   "currency": "860",
//   "is_contract": true,
//   "property_status": "NEW",
//   "email": "abror.esonaliyev@gmail.com",
//   "phone_number": "998977521770",
//   "type_status": "BUY_SERVICE",
//   "to_price": 2343453,
//   "from_price": 123454,
//   "address_id": 6047,
//   "is_auto_renew": true,
//   "show_social": false,
//   "delivery_types": [
//   {
//   "district_id": 2603,
//   "type": "REQUEST"
//   }
//   ],
//   "payment_types": [
//   1,
//   6
//   ],
//   "values": []
// }

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

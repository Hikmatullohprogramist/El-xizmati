import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/network/extensions/rest_mappers.dart';
import 'package:onlinebozor/domain/models/ad/ad_transaction_type.dart';
import 'package:onlinebozor/domain/models/ad/ad_type.dart';

import '../constants/rest_query_keys.dart';

@lazySingleton
class AdCreationService {
  final Dio dio;

  AdCreationService(this.dio);

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

  Future<Response> createOrUpdateProductAd({
    required int? adId,
    //
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

      "address_id": addressId,
      "contact_name": contactPerson,
      "email": email,
      "phone_number": phone,

      "route_type": accountType,
      "property_status": propertyStatus,

      "show_social": isShowMySocialAccount,
      "has_shipping": isPaidDeliveryEnabled,
      "has_free_shipping": isFreeDeliveryEnabled,
      "main_type_status": AdTransactionType.SELL.name, // will be constant

      "sale_type": AdType.PRODUCT.name.toUpperCase(),
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
        "paid_delivery_price": paidDeliveryPrice,
        "paid_delivery_unit_id": 12, // km unit id 12
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

    if (adId != null) {
      final updateBody = {
        RestQueryKeys.adId: adId,
      };
      commonBody.addAll(updateBody);
    }

    var endPoint = "api/mobile/v1/create-product-ad";
    if (adTransactionType == AdTransactionType.FREE) {
      endPoint = adId != null
          ? "api/mobile/v1/update-free-product-ad"
          : "api/mobile/v1/create-free-product-ad";
    } else if (adTransactionType == AdTransactionType.EXCHANGE) {
      endPoint = adId != null
          ? "api/mobile/v1/update-exchange-product-ad"
          : "api/mobile/v1/create-exchange-product-ad";
    } else {
      endPoint = adId != null
          ? "api/mobile/v1/update-product-ad"
          : "api/mobile/v1/create-product-ad";
    }

    return adId != null
        ? dio.put(endPoint, data: commonBody)
        : dio.post(endPoint, data: commonBody);
  }

  Future<Response> createOrUpdateServiceAd({
    required int? adId,
    //
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

      "address_id": addressId,
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
      "deliveries": serviceDistricts.toMapList("district_id"),

      // "type_status": AdTransactionType.SERVICE.name,
      // "main_type_status": AdTransactionType.SELL.name,
      "sale_type": AdType.SERVICE.name.toUpperCase(),

      "is_auto_renew": isAutoRenewal,
      "show_social": isShowMySocialAccount,
      "video": videoUrl
    };

    if (adId != null) {
      final updateBody = {
        RestQueryKeys.adId: adId,
      };
      commonBody.addAll(updateBody);
    }

    final endPoint = adId != null
        ? 'api/mobile/v1/update-service-ad'
        : 'api/mobile/v1/create-service-ad';

    return adId != null
        ? dio.put(endPoint, data: commonBody)
        : dio.post(endPoint, data: commonBody);
  }

  Future<Response> createOrUpdateRequestAd({
    required int? adId,
    //
    required String title,
    required int categoryId,
    required int serviceCategoryId,
    required int serviceSubCategoryId,
    //
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

      "address_id": addressId,
      "deliveries": requestDistricts.toMapList("district_id"),

      "sale_type": adType.name.toUpperCase(),

      "is_auto_renew": isAutoRenewal,
    };

    if (adId != null) {
      final updateBody = {
        RestQueryKeys.adId: adId,
      };
      commonBody.addAll(updateBody);
    }

    final endPoint = adType == AdType.PRODUCT
        ? adId != null
            ? "api/mobile/v1/update-product-request"
            : "api/mobile/v1/create-product-request"
        : adId != null
            ? "api/mobile/v1/update-service-request"
            : "api/mobile/v1/create-service-request";

    return adId != null
        ? dio.put(endPoint, data: commonBody)
        : dio.post(endPoint, data: commonBody);
  }

  Future<Response> getProductAdForEdit({required int adId}) {
    final queryParameters = {RestQueryKeys.adId: adId};
    return dio.get(
      "api/mobile/v1/get-product-ad-details-for-edit",
      queryParameters: queryParameters,
    );
  }

  Future<Response> getServiceAdForEdit({required int adId}) {
    final queryParameters = {RestQueryKeys.adId: adId};
    return dio.get(
      "api/mobile/v1/get-service-ad-details-for-edit",
      queryParameters: queryParameters,
    );
  }

  Future<Response> getRequestAdForEdit({required int adId}) {
    final queryParameters = {RestQueryKeys.adId: adId};
    return dio.get(
      "api/mobile/v1/get-request-ad-details-for-edit",
      queryParameters: queryParameters,
    );
  }

  Future<Response> getUserAdDetail({required int adId}) {
    final queryParameters = {RestQueryKeys.id: adId};
    return dio.get(
      "api/mobile/v1/ads/get-user-ad-detail",
      queryParameters: queryParameters,
    );
  }
}

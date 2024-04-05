import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/responses/ad/creation/ad_creation_response.dart';
import 'package:onlinebozor/data/responses/ad/edit/product_ad_response.dart';
import 'package:onlinebozor/data/responses/ad/edit/request_ad_response.dart';
import 'package:onlinebozor/data/responses/ad/edit/service_ad_response.dart';
import 'package:onlinebozor/data/responses/category/category/category_response.dart';
import 'package:onlinebozor/data/responses/currencies/currency_response.dart';
import 'package:onlinebozor/data/services/ad_creation_service.dart';
import 'package:onlinebozor/domain/models/ad/ad_transaction_type.dart';
import 'package:onlinebozor/domain/models/ad/ad_type.dart';
import 'package:onlinebozor/domain/models/district/district.dart';

import '../../domain/models/image/uploadable_file.dart';
import '../responses/address/user_address_response.dart';
import '../responses/payment_type/payment_type_response.dart';
import '../responses/unit/unit_response.dart';
import '../storages/user_storage.dart';

@LazySingleton()
class AdCreationRepository {
  final AdCreationService _adCreationService;
  final UserInfoStorage _userInfoStorage;

  AdCreationRepository(this._adCreationService, this._userInfoStorage);

  Future<List<CategoryResponse>> getCategoriesForCreationAd(String type) async {
    final response = await _adCreationService.getCategoriesForCreationAd(type);
    final categories = CategoryRootResponse.fromJson(response.data).data;
    return categories;
  }

  Future<List<CurrencyResponse>> getCurrenciesForCreationAd() async {
    final response = await _adCreationService.getCurrenciesForCreationAd();
    final currencies = CurrencyRootResponse.fromJson(response.data).data;
    return currencies;
  }

  Future<List<PaymentTypeResponse>> getPaymentTypesForCreationAd() async {
    final response = await _adCreationService.getPaymentTypesForCreationAd();
    final paymentTypes = PaymentTypeRootResponse.fromJson(response.data).data;
    return paymentTypes;
  }

  Future<List<UserAddressResponse>> getWarehousesForCreationAd() async {
    var tin = _userInfoStorage.userInformation.call()?.tin;
    var pinfl = _userInfoStorage.userInformation.call()?.pinfl;
    final response = await _adCreationService.getWarehousesForCreationAd(
      tinOrPinfl: tin ?? pinfl ?? 0,
    );
    final warehouses = UserAddressRootResponse.fromJson(response.data).data;
    return warehouses;
  }

  Future<List<UnitResponse>> getUnitsForCreationAd() async {
    final response = await _adCreationService.getUnitsForCreationAd();
    final units = UnitRootResponse.fromJson(response.data).data;
    return units;
  }

  Future<UploadableFile> uploadImage(UploadableFile file) async {
    var response = await _adCreationService.uploadImage(file.xFile!);
    var id = response.data['id'];
    if (id is String) {
      return file..id = id;
    }

    throw Exception("Rasm yuklashda xatolik");
  }

  Future<int> createProductAd({
    required int? adId,
    //
    required String title,
    required CategoryResponse category,
    required AdTransactionType adTransactionType,
    //
    required String mainImageId,
    required List<String> pickedImageIds,
    //
    required String desc,
    required int? warehouseCount,
    required UnitResponse? unit,
    required int minAmount,
    required int? price,
    required CurrencyResponse? currency,
    required List<PaymentTypeResponse> paymentTypes,
    required bool isAgreedPrice,
    //
    required String propertyStatus,
    required String accountType,
    //
    required String exchangeTitle,
    required String exchangeDesc,
    required CategoryResponse? exchangeCategory,
    required String exchangeAccountType,
    required String exchangePropertyStatus,
    //
    required UserAddressResponse? address,
    required String contactPerson,
    required String phone,
    required String email,
    //
    required bool isPickupEnabled,
    required List<UserAddressResponse> pickupWarehouses,
    required bool isFreeDeliveryEnabled,
    required int freeDeliveryMaxDay,
    required List<District> freeDeliveryDistricts,
    required bool isPaidDeliveryEnabled,
    required int paidDeliveryMaxDay,
    required int? paidDeliveryPrice,
    required List<District> paidDeliveryDistricts,
    //
    required bool isAutoRenewal,
    required bool isShowMySocialAccount,
    required String videoUrl,
  }) async {
    final response = await _adCreationService.createProductAd(
      adId: adId,
      //
      title: title,
      categoryId: category.id,
      adTransactionType: adTransactionType,
      //
      mainImageId: mainImageId,
      pickedImageIds: pickedImageIds,
      //
      desc: desc,
      warehouseCount: warehouseCount,
      unitId: unit?.id,
      minAmount: minAmount,
      price: price,
      currency: currency?.id,
      paymentTypeIds: paymentTypes.map((e) => "${e.id}").toList(),
      isAgreedPrice: isAgreedPrice,
      //
      propertyStatus: propertyStatus,
      accountType: accountType,
      //
      exchangeTitle: exchangeTitle,
      exchangeCategoryId: exchangeCategory?.id,
      exchangeDesc: exchangeDesc,
      exchangePropertyStatus: exchangePropertyStatus,
      exchangeAccountType: exchangeAccountType,
      //
      addressId: address?.id,
      contactPerson: contactPerson,
      phone: phone,
      email: email,
      //
      isPickupEnabled: isPickupEnabled,
      pickupWarehouses: pickupWarehouses.map((e) => e.id).toList(),
      isFreeDeliveryEnabled: isFreeDeliveryEnabled,
      freeDeliveryMaxDay: freeDeliveryMaxDay,
      freeDeliveryDistricts: freeDeliveryDistricts.map((e) => e.id).toList(),
      isPaidDeliveryEnabled: isPaidDeliveryEnabled,
      paidDeliveryMaxDay: paidDeliveryMaxDay,
      paidDeliveryPrice: paidDeliveryPrice,
      paidDeliveryDistricts: paidDeliveryDistricts.map((e) => e.id).toList(),
      //
      isAutoRenewal: isAutoRenewal,
      isShowMySocialAccount: isShowMySocialAccount,
      videoUrl: videoUrl,
    );

    final id = AdCreationRootResponse.fromJson(response.data).data.ad.id;
    return id;
  }

  Future<int> createServiceAd({
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
    required CurrencyResponse currency,
    required List<PaymentTypeResponse> paymentTypes,
    required bool isAgreedPrice,
    //
    required String accountType,
    required List<District> serviceDistricts,
    //
    required UserAddressResponse address,
    required String contactPerson,
    required String phone,
    required String email,
    //
    required bool isAutoRenewal,
    required bool isShowMySocialAccount,
    required String videoUrl,
  }) async {
    final response = await _adCreationService.createServiceAd(
      adId: adId,
      //
      title: title,
      categoryId: categoryId,
      serviceCategoryId: serviceCategoryId,
      serviceSubCategoryId: serviceSubCategoryId,
      //
      mainImageId: mainImageId,
      pickedImageIds: pickedImageIds,
      //
      desc: desc,
      fromPrice: fromPrice,
      toPrice: toPrice,
      currency: currency.id,
      paymentTypeIds: paymentTypes.map((e) => "${e.id}").toList(),
      isAgreedPrice: isAgreedPrice,
      //
      accountType: accountType,
      serviceDistricts: serviceDistricts.map((e) => e.id).toList(),
      //
      addressId: address.id,
      contactPerson: contactPerson,
      phone: phone,
      email: email,
      //
      isAutoRenewal: isAutoRenewal,
      isShowMySocialAccount: isShowMySocialAccount,
      videoUrl: videoUrl,
    );

    final id = AdCreationRootResponse.fromJson(response.data).data.ad.id;
    return id;
  }

  Future<int> createRequestAd({
    required int? adId,
    //
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
    required CurrencyResponse currency,
    required List<PaymentTypeResponse> paymentTypes,
    required bool isAgreedPrice,
    //
    required List<District> requestDistricts,
    //
    required UserAddressResponse address,
    required String contactPerson,
    required String phone,
    required String email,
    //
    required bool isAutoRenewal,
  }) async {
    final response = await _adCreationService.createRequestAd(
      adId: adId,
      //
      title: title,
      categoryId: categoryId,
      adType: adType,
      adTransactionType: adTransactionType,
      //
      mainImageId: mainImageId,
      pickedImageIds: pickedImageIds,
      //
      desc: desc,
      fromPrice: fromPrice,
      toPrice: toPrice,
      currency: currency.id,
      paymentTypeIds: paymentTypes.map((e) => "${e.id}").toList(),
      isAgreedPrice: isAgreedPrice,
      //
      requestDistricts: requestDistricts.map((e) => e.id).toList(),
      //
      addressId: address.id,
      contactPerson: contactPerson,
      phone: phone,
      email: email,
      //
      isAutoRenewal: isAutoRenewal,
    );

    final id = AdCreationRootResponse.fromJson(response.data).data.ad.id;
    return id;
  }

  Future<ProductAdResponse> getProductAdForEdit({required int adId}) async {
    final response = await _adCreationService.getProductAdForEdit(adId: adId);
    final adsResponse = ProductAdRootResponse.fromJson(response.data).data;
    return adsResponse;
  }

  Future<ServiceAdResponse> getServiceAdForEdit({required int adId}) async {
    final response = await _adCreationService.getServiceAdForEdit(adId: adId);
    final adsResponse = ServiceAdRootResponse.fromJson(response.data).data;
    return adsResponse;
  }

  Future<RequestAdResponse> getRequestAdForEdit({required int adId}) async {
    final response = await _adCreationService.getRequestAdForEdit(adId: adId);
    final adsResponse = RequestAdRootResponse.fromJson(response.data).data;
    return adsResponse;
  }
}

import 'package:El_xizmati/data/datasource/floor/dao/category_entity_dao.dart';
import 'package:El_xizmati/data/datasource/network/responses/ad/creation/ad_creation_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/ad/edit/product_ad_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/ad/edit/request_ad_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/ad/edit/service_ad_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/address/user_address_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/category/category/category_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/currencies/currency_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/payment_type/payment_type_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/unit/unit_response.dart';
import 'package:El_xizmati/data/datasource/network/services/private/ad_creation_service.dart';
import 'package:El_xizmati/data/datasource/preference/user_preferences.dart';
import 'package:El_xizmati/data/mappers/category_mappers.dart';
import 'package:El_xizmati/domain/mappers/common_mapper_exts.dart';
import 'package:El_xizmati/domain/mappers/user_mapper.dart';
import 'package:El_xizmati/domain/models/ad/ad_transaction_type.dart';
import 'package:El_xizmati/domain/models/ad/ad_type.dart';
import 'package:El_xizmati/domain/models/category/category.dart';
import 'package:El_xizmati/domain/models/category/category_type.dart';
import 'package:El_xizmati/domain/models/district/district.dart';
import 'package:El_xizmati/domain/models/image/uploadable_file.dart';
import 'package:El_xizmati/domain/models/user/user_address.dart';

class AdCreationRepository {
  final AdCreationService _adCreationService;
  final CategoryEntityDao _categoryEntityDao;
  final UserPreferences _userPreferences;

  AdCreationRepository(
    this._adCreationService,
    this._categoryEntityDao,
    this._userPreferences,
  );

  Future<List<Category>> getAdCreationCategories(
    CategoryType categoryType,
  ) async {
    final type = categoryType.stringValue;
    final count = await _categoryEntityDao.getCategoriesCountByType(type) ?? 0;
    if (count <= 0) {
      final response = await _adCreationService.getAdCreationCategories(type);
      final categories = CategoryRootResponse.fromJson(response.data)
          .data
          .map((e) => e.toCategoryEntity(categoryType))
          .toList();
      await _categoryEntityDao.insertCategories(categories);
    }

    final entities = await _categoryEntityDao.getCategoriesByType(type);
    return entities.map((e) => e.toCategory()).toList();
  }

  Future<List<Currency>> getCurrenciesForCreationAd() async {
    final response = await _adCreationService.getCurrenciesForCreationAd();
    final currencies = CurrencyRootResponse.fromJson(response.data).data;
    return currencies;
  }

  Future<List<PaymentTypeResponse>> getPaymentTypesForCreationAd() async {
    final response = await _adCreationService.getPaymentTypesForCreationAd();
    final paymentTypes = PaymentTypeRootResponse.fromJson(response.data).data;
    return paymentTypes;
  }

  Future<List<UserAddress>> getWarehousesForCreationAd() async {
    var tin = _userPreferences.tin;
    var pinfl = _userPreferences.pinfl;
    final response = await _adCreationService.getWarehousesForCreationAd(
      tinOrPinfl: tin ?? pinfl ?? 0,
    );
    final addresses = UserAddressRootResponse.fromJson(response.data).data;
    return addresses.map((e) => e.toAddress()).toList();
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

  Future<int> createOrUpdateProductAd({
    required int? adId,
    //
    required String title,
    required Category category,
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
    required Currency? currency,
    required List<PaymentTypeResponse> paymentTypes,
    required bool isAgreedPrice,
    //
    required String propertyStatus,
    required String accountType,
    //
    required String exchangeTitle,
    required String exchangeDesc,
    required Category? exchangeCategory,
    required String exchangeAccountType,
    required String exchangePropertyStatus,
    //
    required UserAddress? address,
    required String contactPerson,
    required String phone,
    required String email,
    //
    required bool isPickupEnabled,
    required List<UserAddress> pickupWarehouses,
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
    final response = await _adCreationService.createOrUpdateProductAd(
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

    final id = adId ??
        AdCreationRootResponse.fromJson(response.data).data.insert_ad?.id ??
        -1;
    return id;
  }

  Future<int> createOrUpdateServiceAd({
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
    required Currency currency,
    required List<PaymentTypeResponse> paymentTypes,
    required bool isAgreedPrice,
    //
    required String accountType,
    required List<District> serviceDistricts,
    //
    required UserAddress address,
    required String contactPerson,
    required String phone,
    required String email,
    //
    required bool isAutoRenewal,
    required bool isShowMySocialAccount,
    required String videoUrl,
  }) async {
    final response = await _adCreationService.createOrUpdateServiceAd(
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

    final id = adId ??
        AdCreationRootResponse.fromJson(response.data).data.insert_ad?.id ??
        -1;
    return id;
  }

  Future<int> createOrUpdateRequestAd({
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
    required Currency currency,
    required List<PaymentTypeResponse> paymentTypes,
    required bool isAgreedPrice,
    //
    required List<District> requestDistricts,
    //
    required UserAddress address,
    required String contactPerson,
    required String phone,
    required String email,
    //
    required bool isAutoRenewal,
  }) async {
    final response = await _adCreationService.createOrUpdateRequestAd(
      adId: adId,
      //
      title: title,
      categoryId: categoryId,
      serviceCategoryId: serviceCategoryId,
      serviceSubCategoryId: serviceSubCategoryId,
      //
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

    final id = adId ??
        AdCreationRootResponse.fromJson(response.data).data.insert_ad?.id ??
        -1;
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

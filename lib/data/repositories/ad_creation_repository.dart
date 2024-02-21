import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/responses/category/category/category_response.dart';
import 'package:onlinebozor/data/responses/category/category_selection/category_selection_response.dart';
import 'package:onlinebozor/data/responses/currencies/currency_response.dart';
import 'package:onlinebozor/data/services/ad_creation_service.dart';

import '../responses/payment_type/payment_type_response.dart';
import '../responses/unit/unit_response.dart';

@LazySingleton()
class AdCreationRepository {
  final AdCreationService _adCreationService;

  AdCreationRepository(this._adCreationService);

  Future<List<CategorySelectionResponse>> getCategoriesForCreationAd() async {
    final response = await _adCreationService.getCategoriesForCreationAd();
    final categories = CategorySelectionRootResponse.fromJson(response.data).data;
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

  Future<List<UnitResponse>> getUnitsForCreationAd() async {
    final response = await _adCreationService.getUnitsForCreationAd();
    final units = UnitRootResponse.fromJson(response.data).data;
    return units;
  }
}

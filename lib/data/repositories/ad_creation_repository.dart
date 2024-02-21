import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/services/ad_creation_service.dart';

import '../responses/payment_type/payment_type_response.dart';
import '../responses/unit/unit_response.dart';

@LazySingleton()
class AdCreationRepository {
  final AdCreationService _adCreationService;

  AdCreationRepository(this._adCreationService);

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

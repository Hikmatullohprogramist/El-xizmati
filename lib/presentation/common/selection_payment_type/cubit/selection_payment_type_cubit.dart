import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/data/repositories/ad_creation_repository.dart';
import 'package:onlinebozor/data/responses/payment_type/payment_type_response.dart';

import '../../../../../../common/enum/enums.dart';
import '../../../../data/repositories/common_repository.dart';

part 'selection_payment_type_cubit.freezed.dart';

part 'selection_payment_type_state.dart';

@Injectable()
class SelectionPaymentTypeCubit extends BaseCubit<SelectionPaymentTypeBuildable,
    SelectionPaymentTypeListenable> {
  SelectionPaymentTypeCubit(this._repository)
      : super(SelectionPaymentTypeBuildable()) {
    getPaymentTypes();
  }

  final AdCreationRepository _repository;

  Future<void> getPaymentTypes() async {
    try {
      final paymentTypes = await _repository.getPaymentTypesForCreationAd();
      log.i(paymentTypes.toString());
      build(
        (buildable) => buildable.copyWith(
          paymentTypes: paymentTypes,
          paymentTypesState: LoadingState.success,
        ),
      );
    } on DioException catch (exception) {
      log.e(exception.toString());
    }
  }

  void setInitialSelectedPaymentTypes(List<PaymentTypeResponse>? paymentTypes) {
    try {
      if (paymentTypes != null) {
        List<PaymentTypeResponse> updatedSelectedPaymentTypes = [];
        updatedSelectedPaymentTypes.addAll(paymentTypes);
        build(
          (buildable) => buildable.copyWith(
            selectedPaymentTypes: updatedSelectedPaymentTypes,
          ),
        );
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  void updateSelectedPaymentTypes(PaymentTypeResponse paymentType) {
    try {
      var updatedSelectedPaymentTypes =
          List<PaymentTypeResponse>.from(buildable.selectedPaymentTypes);

      if (buildable.selectedPaymentTypes.contains(paymentType)) {
        updatedSelectedPaymentTypes.remove(paymentType);
      } else {
        updatedSelectedPaymentTypes.add(paymentType);
      }

      build(
        (buildable) => buildable.copyWith(
          selectedPaymentTypes: updatedSelectedPaymentTypes,
        ),
      );
    } catch (e) {
      log.e(e.toString());
    }
  }
}

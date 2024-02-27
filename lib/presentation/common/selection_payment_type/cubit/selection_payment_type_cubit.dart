import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/data/repositories/ad_creation_repository.dart';
import 'package:onlinebozor/data/responses/payment_type/payment_type_response.dart';

import '../../../../../../common/enum/enums.dart';

part 'selection_payment_type_cubit.freezed.dart';

part 'selection_payment_type_state.dart';

@Injectable()
class SelectionPaymentTypeCubit extends BaseCubit<SelectionPaymentTypeBuildable,
    SelectionPaymentTypeListenable> {
  SelectionPaymentTypeCubit(this._repository)
      : super(SelectionPaymentTypeBuildable()) {
    getItems();
  }

  final AdCreationRepository _repository;

   var listmy=["sk","sk","sk","sk","sk","sk","sk","sk","sk","sk"];

  Future<void> getItems() async {
    try {
      final paymentTypes = await _repository.getPaymentTypesForCreationAd();
      log.i(paymentTypes.toString());
      build(
        (buildable) => buildable.copyWith(
          items: paymentTypes,
          itemsLoadState: LoadingState.success,
        ),
      );
    } on DioException catch (exception) {
      log.e(exception.toString());
      build(
        (buildable) => buildable.copyWith(
          itemsLoadState: LoadingState.error,
        ),
      );
    }
  }

  void setInitialSelectedItems(List<PaymentTypeResponse>? paymentTypes) {
    try {
      if (paymentTypes != null) {
        List<PaymentTypeResponse> updatedSelectedItems = [];
        updatedSelectedItems.addAll(paymentTypes);
        build(
          (buildable) => buildable.copyWith(
            selectedItems: updatedSelectedItems,
          ),
        );
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  void updateSelectedItems(PaymentTypeResponse paymentType) {
    try {
      var updatedSelectedItems =
          List<PaymentTypeResponse>.from(buildable.selectedItems);

      if (buildable.selectedItems.contains(paymentType)) {
        updatedSelectedItems.remove(paymentType);
      } else {
        updatedSelectedItems.add(paymentType);
      }

      build(
        (buildable) => buildable.copyWith(
          selectedItems: updatedSelectedItems,
        ),
      );
    } catch (e) {
      log.e(e.toString());
    }
  }
}

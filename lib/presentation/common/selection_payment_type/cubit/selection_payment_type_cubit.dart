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
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._repository) : super(PageState()) {
    getItems();
  }

  final AdCreationRepository _repository;

  Future<void> getItems() async {
    try {
      final paymentTypes = await _repository.getPaymentTypesForCreationAd();
      log.i(paymentTypes.toString());
      updateState(
        (state) => state.copyWith(
          items: paymentTypes,
          loadState: LoadingState.success,
        ),
      );
    } on DioException catch (exception) {
      log.e(exception.toString());
      updateState((state) => state.copyWith(loadState: LoadingState.error));
    }
  }

  void setInitialSelectedItems(List<PaymentTypeResponse>? paymentTypes) {
    try {
      if (paymentTypes != null) {
        List<PaymentTypeResponse> selectedItems = [];
        selectedItems.addAll(paymentTypes);
        updateState((state) => state.copyWith(selectedItems: selectedItems));
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  void updateSelectedItems(PaymentTypeResponse paymentType) {
    try {
      var selectedItems = List<PaymentTypeResponse>.from(states.selectedItems);

      if (states.selectedItems.contains(paymentType)) {
        selectedItems.remove(paymentType);
      } else {
        selectedItems.add(paymentType);
      }

      updateState((state) => state.copyWith(selectedItems: selectedItems));
    } catch (e) {
      log.e(e.toString());
    }
  }
}

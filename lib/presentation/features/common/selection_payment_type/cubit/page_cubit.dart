import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/data/repositories/ad_creation_repository.dart';
import 'package:onlinebozor/data/datasource/network/responses/payment_type/payment_type_response.dart';

import '../../../../../../core/enum/enums.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._repository) : super(PageState()) {
    getItems();
  }

  final AdCreationRepository _repository;

  void setInitialParams(List<PaymentTypeResponse>? paymentTypes) {
    try {
      if (paymentTypes != null) {
        List<PaymentTypeResponse> selectedItems = [];
        selectedItems.addAll(paymentTypes);
        updateState((state) => state.copyWith(selectedItems: selectedItems));
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  Future<void> getItems() async {
    updateState((state) => state.copyWith(loadState: LoadingState.loading));
    try {
      final paymentTypes = await _repository.getPaymentTypesForCreationAd();
      logger.i(paymentTypes.toString());
      updateState(
        (state) => state.copyWith(
          items: paymentTypes,
          loadState: LoadingState.success,
        ),
      );
    } catch (exception) {
      logger.e(exception.toString());
      updateState((state) => state.copyWith(loadState: LoadingState.error));
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
      logger.e(e.toString());
    }
  }
}

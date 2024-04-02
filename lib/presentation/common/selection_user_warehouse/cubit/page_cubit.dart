import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/data/repositories/ad_creation_repository.dart';
import 'package:onlinebozor/data/responses/address/user_address_response.dart';

import '../../../../../../common/enum/enums.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._repository) : super(PageState()) {
    getItems();
  }

  final AdCreationRepository _repository;

  Future<void> getItems() async {
    try {
      final warehouses = await _repository.getWarehousesForCreationAd();
      log.i(warehouses.toString());
      updateState(
        (state) => state.copyWith(
          items: warehouses,
          loadState: LoadingState.success,
        ),
      );
    } catch (exception) {
      log.e(exception.toString());
      updateState((state) => state.copyWith(loadState: LoadingState.error));
    }
  }

  void setInitialSelectedParams(List<UserAddressResponse>? warehouses) {
    try {
      if (warehouses != null) {
        List<UserAddressResponse> selectedItems = [];
        selectedItems.addAll(warehouses);
        updateState((state) => state.copyWith(selectedItems: selectedItems));
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  void updateSelectedItems(UserAddressResponse warehouse) {
    try {
      var selectedItems = List<UserAddressResponse>.from(states.selectedItems);

      if (states.selectedItems.contains(warehouse)) {
        selectedItems.remove(warehouse);
      } else {
        selectedItems.add(warehouse);
      }

      updateState((state) => state.copyWith(selectedItems: selectedItems));
    } catch (e) {
      log.e(e.toString());
    }
  }
}

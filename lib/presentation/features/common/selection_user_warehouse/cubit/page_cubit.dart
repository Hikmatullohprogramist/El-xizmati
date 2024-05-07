import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/cubit/base_cubit.dart';
import 'package:onlinebozor/data/repositories/ad_creation_repository.dart';
import 'package:onlinebozor/data/datasource/network/responses/address/user_address_response.dart';
import 'package:onlinebozor/domain/models/user/user_address.dart';

import '../../../../../../core/enum/enums.dart';

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
      logger.i(warehouses.toString());
      updateState(
        (state) => state.copyWith(
          items: warehouses,
          loadState: LoadingState.success,
        ),
      );
    } catch (exception) {
      logger.e(exception.toString());
      updateState((state) => state.copyWith(loadState: LoadingState.error));
    }
  }

  void setInitialSelectedParams(List<UserAddress>? warehouses) {
    try {
      if (warehouses != null) {
        List<UserAddress> selectedItems = [];
        selectedItems.addAll(warehouses);
        updateState((state) => state.copyWith(selectedItems: selectedItems));
      }
    } catch (e) {
      logger.e(e.toString());
    }
  }

  void updateSelectedItems(UserAddress warehouse) {
    try {
      var selectedItems = List<UserAddress>.from(states.selectedItems);

      if (states.selectedItems.contains(warehouse)) {
        selectedItems.remove(warehouse);
      } else {
        selectedItems.add(warehouse);
      }

      updateState((state) => state.copyWith(selectedItems: selectedItems));
    } catch (e) {
      logger.e(e.toString());
    }
  }
}

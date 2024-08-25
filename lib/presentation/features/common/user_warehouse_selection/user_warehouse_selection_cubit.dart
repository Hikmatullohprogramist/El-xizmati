import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/core/enum/enums.dart';
import 'package:El_xizmati/data/repositories/ad_creation_repository.dart';
import 'package:El_xizmati/domain/models/user/user_address.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';

part 'user_warehouse_selection_cubit.freezed.dart';
part 'user_warehouse_selection_state.dart';

@Injectable()
class UserWarehouseSelectionCubit extends BaseCubit<UserWarehouseSelectionState,
    UserWarehouseSelectionEvent> {
  final AdCreationRepository _repository;

  UserWarehouseSelectionCubit(this._repository)
      : super(UserWarehouseSelectionState()) {
    getItems();
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

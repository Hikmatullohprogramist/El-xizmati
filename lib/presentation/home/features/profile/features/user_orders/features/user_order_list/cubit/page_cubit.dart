import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';

import '../../../../../../../../../common/enum/enums.dart';
import '../../../../../../../../../data/repositories/user_order_repository.dart';
import '../../../../../../../../../data/responses/user_order/user_order_response.dart';
import '../../../../../../../../../domain/models/order/order_type.dart';
import '../../../../../../../../../domain/models/order/user_order_status.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.userOrderRepository) : super(PageState()) {
    getController();
  }

  final UserOrderRepository userOrderRepository;

  void setInitialParams(OrderType orderType, UserOrderStatus status) {
    updateState(
      (state) => states.copyWith(orderType: orderType, userOrderStatus: status),
    );
  }

  Future<void> getController() async {
    try {
      final controller = states.controller ?? getOrderController(status: 1);
      updateState((state) => states.copyWith(controller: controller));
    } catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      // updateState(
      //     (state) => state.copyWith(controller: state.controller?.error = e));
    } finally {
      log.i(states.controller);
    }
  }

  PagingController<int, UserOrder> getOrderController({required int status}) {
    final controller = PagingController<int, UserOrder>(
      firstPageKey: 1,
      invisibleItemsThreshold: 100,
    );
    log.i(states.controller);

    controller.addPageRequestListener(
      (pageKey) async {
        try {
          final orderList = await userOrderRepository.getUserOrders(
            limit: 20,
            userOrderStatus: states.userOrderStatus,
            page: pageKey,
            orderType: states.orderType,
          );
          if (orderList.length <= 19) {
            controller.appendLastPage(orderList);
            log.i(states.controller);
            return;
          }
          controller.appendPage(orderList, pageKey + 1);
        } catch (e) {
          log.i(
              "pageKey = $pageKey, orderType = ${states.orderType}, error = $e");
          controller.error(e);
        }
      },
    );
    return controller;
  }

  void updateCancelledOrder(UserOrder order) {
    final index = states.controller?.itemList?.indexOf(order) ?? 0;
    final item = states.controller?.itemList?.elementAt(index);
    if (item != null) {
      states.controller?.itemList?.removeAt(index);
      states.controller?.itemList
          ?.insert(index, item.copyWith(status: UserOrderStatus.CANCELED.name));
      states.controller?.notifyListeners();
    }
  }
}

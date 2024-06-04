import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/datasource/network/responses/user_order/user_order_response.dart';
import 'package:onlinebozor/data/repositories/user_order_repository.dart';
import 'package:onlinebozor/domain/models/order/order_type.dart';
import 'package:onlinebozor/domain/models/order/user_order_status.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/presentation/support/extensions/extension_message_exts.dart';

part 'user_order_list_cubit.freezed.dart';
part 'user_order_list_state.dart';

@Injectable()
class UserOrderListCubit
    extends BaseCubit<UserOrderListState, UserOrderListEvent> {
  final UserOrderRepository userOrderRepository;

  UserOrderListCubit(this.userOrderRepository) : super(UserOrderListState()) {
    getController();
  }

  void setInitialParams(OrderType orderType, UserOrderStatus status) {
    updateState((state) => states.copyWith(
          orderType: orderType,
          userOrderStatus: status,
        ));
  }

  Future<void> getController() async {
    try {
      final controller = states.controller ?? getOrderController(status: 1);
      updateState((state) => states.copyWith(controller: controller));
    } catch (e, stackTrace) {
      logger.e(e.toString(), error: e, stackTrace: stackTrace);
      // updateState(
      //     (state) => state.copyWith(controller: state.controller?.error = e));
    } finally {
      logger.i(states.controller);
    }
  }

  PagingController<int, UserOrder> getOrderController({required int status}) {
    final controller = PagingController<int, UserOrder>(
      firstPageKey: 1,
      invisibleItemsThreshold: 100,
    );
    logger.i(states.controller);

    controller.addPageRequestListener(
      (pageKey) async {
        userOrderRepository
            .getUserOrders(
              limit: 20,
              userOrderStatus: states.userOrderStatus,
              page: pageKey,
              orderType: states.orderType,
            )
            .initFuture()
            .onStart(() {})
            .onSuccess((data) {
              if (data.length <= 19) {
                controller.appendLastPage(data);
                logger.i(states.controller);
                return;
              }
              controller.appendPage(data, pageKey + 1);
            })
            .onError((error) {
              controller.error = error;
              if (error.isRequiredShowError) {
                stateMessageManager
                    .showErrorBottomSheet(error.localizedMessage);
              }
            })
            .onFinished(() {})
            .executeFuture();
      },
    );
    return controller;
  }

  void updateCancelledOrder(UserOrder order) {
    int index = states.controller?.itemList
            ?.indexWhere((e) => e.orderId == order.orderId) ??
        -1;

    final item =
        index >= 0 ? states.controller?.itemList?.elementAt(index) : null;

    if (item != null) {
      states.controller?.itemList?.removeAt(index);
      states.controller?.itemList?.insert(
        index,
        item.copyWith(status: order.status, cancelNote: order.cancelNote),
      );
      states.controller?.notifyListeners();
    }
  }
}

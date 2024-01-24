import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';

import '../../../../../../../../../common/enum/enums.dart';
import '../../../../../../../../../data/responses/user_order/user_order_response.dart';
import '../../../../../../../../../domain/models/order/order_type.dart';
import '../../../../../../../../../domain/models/order/user_order_status.dart';
import '../../../../../../../../../domain/repositories/user_order_repository.dart';

part 'user_reject_orders_cubit.freezed.dart';
part 'user_reject_orders_state.dart';

@injectable
class UserRejectOrdersCubit
    extends BaseCubit<UserRejectOrdersBuildable, UserRejectOrdersListenable> {
  UserRejectOrdersCubit(this.userOrderRepository) : super(UserRejectOrdersBuildable()){
    getController();
  }

  final UserOrderRepository userOrderRepository;

  void setInitialOrderType(OrderType orderType) {
    build((buildable) => buildable.copyWith(orderType: orderType));
  }

  Future<void> getController() async {
    try {
      final controller =
          buildable.userOrderPagingController ?? getOrderController(status: 1);
      build((buildable) =>
          buildable.copyWith(userOrderPagingController: controller));
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(buildable.userOrderPagingController);
    }
  }

  PagingController<int, UserOrderResponse> getOrderController({
    required int status,
  }) {
    final adController = PagingController<int, UserOrderResponse>(
        firstPageKey: 1, invisibleItemsThreshold: 100);
    log.i(buildable.userOrderPagingController);

    adController.addPageRequestListener(
          (pageKey) async {
        final orderList = await userOrderRepository.getUserOrders(
            limit: 20,
            userOrderStatus: UserOrderStatus.rejected,
            page: pageKey,
            orderType: buildable.orderType);
        if (orderList.length <= 19) {
          adController.appendLastPage(orderList);
          log.i(buildable.userOrderPagingController);
          return;
        }
        adController.appendPage(orderList, pageKey + 1);
        log.i(buildable.userOrderPagingController);
      },
    );
    return adController;
  }
}

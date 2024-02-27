import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';

import '../../../../../../../../../common/enum/enums.dart';
import '../../../../../../../../../data/responses/user_order/user_order_response.dart';
import '../../../../../../../../../domain/models/order/order_type.dart';
import '../../../../../../../../../domain/models/order/user_order_status.dart';
import '../../../../../../../../../data/repositories/user_order_repository.dart';

part 'user_review_orders_cubit.freezed.dart';
part 'user_review_orders_state.dart';

@Injectable()
class UserReviewOrdersCubit
    extends BaseCubit<UserReviewOrdersBuildable, UserReviewOrdersListenable> {
  UserReviewOrdersCubit(this.userOrderRepository)
      : super(const UserReviewOrdersBuildable()) {
    getController();
  }

  final UserOrderRepository userOrderRepository;

  void setInitialOrderType(OrderType orderType) {
    updateState((buildable) => buildable.copyWith(orderType: orderType));
  }

  Future<void> getController() async {
    try {
      final controller =
          currentState.userOrderPagingController ?? getOrderController(status: 1);
      updateState((buildable) =>
          buildable.copyWith(userOrderPagingController: controller));
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(currentState.userOrderPagingController);
    }
  }

  PagingController<int, UserOrderResponse> getOrderController({
    required int status,
  }) {
    final adController = PagingController<int, UserOrderResponse>(
        firstPageKey: 1, invisibleItemsThreshold: 100);
    log.i(currentState.userOrderPagingController);

    adController.addPageRequestListener(
      (pageKey) async {
        final orderList = await userOrderRepository.getUserOrders(
            limit: 20,
            userOrderStatus: UserOrderStatus.review,
            page: pageKey,
            orderType: currentState.orderType);
        if (orderList.length <= 19) {
          adController.appendLastPage(orderList);
          log.i(currentState.userOrderPagingController);
          return;
        }
        adController.appendPage(orderList, pageKey + 1);
        log.i(currentState.userOrderPagingController);
      },
    );
    return adController;
  }
}

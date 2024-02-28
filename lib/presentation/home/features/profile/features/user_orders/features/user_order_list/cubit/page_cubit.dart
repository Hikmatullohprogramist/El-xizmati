import 'package:dio/dio.dart';
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

  void setInitialOrderType(OrderType orderType) {
    updateState((state) => states.copyWith(orderType: orderType));
  }

  Future<void> getController() async {
    try {
      final controller = states.controller ?? getOrderController(status: 1);
      updateState((state) => states.copyWith(controller: controller));
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(states.controller);
    }
  }

  PagingController<int, UserOrderResponse> getOrderController({
    required int status,
  }) {
    final adController = PagingController<int, UserOrderResponse>(
      firstPageKey: 1,
      invisibleItemsThreshold: 100,
    );
    log.i(states.controller);

    adController.addPageRequestListener(
      (pageKey) async {
        final orderList = await userOrderRepository.getUserOrders(
          limit: 20,
          userOrderStatus: UserOrderStatus.all,
          page: pageKey,
          orderType: states.orderType,
        );
        if (orderList.length <= 19) {
          adController.appendLastPage(orderList);
          log.i(states.controller);
          return;
        }
        adController.appendPage(orderList, pageKey + 1);
        log.i(states.controller);
      },
    );
    return adController;
  }
}

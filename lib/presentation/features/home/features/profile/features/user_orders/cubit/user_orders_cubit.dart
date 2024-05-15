import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/models/order/order_type.dart';

import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'user_orders_cubit.freezed.dart';
part 'user_orders_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit() : super(const PageState());

  void setInitialParams(OrderType orderType) {
    updateState((state) => state.copyWith(orderType: orderType));
  }

  void changeOrderType() {
    updateState((state) => state.copyWith(
          orderType: state.orderType == OrderType.sell
              ? OrderType.buy
              : OrderType.sell,
        ));

    emitEvent(PageEvent(PageEventType.onOrderTypeChange));
  }
}

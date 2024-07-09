import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/domain/models/order/order_type.dart';

import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'user_orders_cubit.freezed.dart';
part 'user_orders_state.dart';

@injectable
class UserOrdersCubit extends BaseCubit<UserOrdersState, UserOrdersEvent> {
  UserOrdersCubit() : super(const UserOrdersState());

  void setInitialParams(OrderType orderType) {
    updateState((state) => state.copyWith(orderType: orderType));
  }

  void changeOrderType() {
    Logger().w("BEFORE UPDATE STATE order type = ${states.orderType}");

    updateState((state) => state.copyWith(
          orderType: state.orderType == OrderType.sell
              ? OrderType.buy
              : OrderType.sell,
        ));

    Logger().w("AFTER UPDATE STATE order type = ${states.orderType}");

    // emitEvent(UserOrdersEvent(UserOrdersEventType.onOrderTypeChange));
  }
}

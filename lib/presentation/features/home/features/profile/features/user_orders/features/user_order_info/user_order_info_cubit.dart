import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/models/order/user_order.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'user_order_info_cubit.freezed.dart';
part 'user_order_info_state.dart';

@Injectable()
class UserOrderInfoCubit
    extends BaseCubit<UserOrderInfoState, UserOrderInfoEvent> {
  UserOrderInfoCubit() : super(UserOrderInfoState());

  void setInitialParams(UserOrder userOrder) {
    updateState((state) => state.copyWith(initialOrder: userOrder));
  }

  void updateCancelledOrder(UserOrder order) {
    updateState((state) => state.copyWith(updatedOrder: order));
  }
}

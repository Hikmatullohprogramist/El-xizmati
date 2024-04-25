import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/common/enum/enums.dart';
import 'package:onlinebozor/data/repositories/user_order_repository.dart';
import 'package:onlinebozor/data/responses/user_order/user_order_response.dart';
import 'package:onlinebozor/domain/models/order/order_cancel_reason.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._userOrderRepository) : super(PageState());

  final UserOrderRepository _userOrderRepository;

  void setInitialParams(UserOrder userOrder) {
    updateState((state) => state.copyWith(
          userOrder: userOrder,
          reasons: OrderCancelReason.values,
        ));
  }

  Future<void> cancelOrder() async {
    updateState((state) => state.copyWith(
          cancelLoadState: LoadingState.loading,
        ));

    try {
      await _userOrderRepository.cancelOrder(
        orderId: states.userOrder!.orderId,
        reason: states.cancelReason,
        comment: states.cancelComment,
      );
      updateState((state) => state.copyWith(
            cancelLoadState: LoadingState.success,
          ));

      log.w("cancelOrder success");
      emitEvent(PageEvent(PageEventType.onBackAfterCancel));
    } catch (e) {
      log.w("cancelOrder error = $e");
      updateState((state) => state.copyWith(
            cancelLoadState: LoadingState.error,
          ));
    }
  }

  void setSelectedReason(OrderCancelReason reason) {
    updateState((state) => state.copyWith(
          cancelReason: reason,
          isCommentEnabled: reason == OrderCancelReason.OTHER_REASON,
        ));
  }

  void setEnteredComment(String comment) {
    updateState((state) => state.copyWith(cancelComment: comment));
  }
}

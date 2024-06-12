import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/repositories/payment_repository.dart';
import 'package:onlinebozor/domain/models/transaction/payment_transaction.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/presentation/support/extensions/extension_message_exts.dart';

part 'payment_transactions_cubit.freezed.dart';
part 'payment_transactions_state.dart';

@injectable
class PaymentTransactionsCubit
    extends BaseCubit<PaymentTransactionsState, PaymentTransactionsEvent> {
  final PaymentRepository _paymentRepository;

  PaymentTransactionsCubit(
    this._paymentRepository,
  ) : super(PaymentTransactionsState()) {
    initController();
  }

  Future<void> initController() async {
    final controller = states.controller ?? getController(status: 1);
    updateState((state) => state.copyWith(controller: controller));
  }

  PagingController<int, PaymentTransaction> getController({
    required int status,
  }) {
    final controller = PagingController<int, PaymentTransaction>(
      firstPageKey: 1,
      invisibleItemsThreshold: 100,
    );
    logger.i(states.controller);

    controller.addPageRequestListener(
      (pageKey) async {
        _paymentRepository
            .getPaymentTransactions(
              pageSize: 20,
              pageIndex: pageKey,
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
}

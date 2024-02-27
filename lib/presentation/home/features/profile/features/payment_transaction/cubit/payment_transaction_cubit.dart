import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../common/core/base_cubit.dart';
import '../../../../../../../common/enum/enums.dart';
import '../../../../../../../data/repositories/transaction_repository.dart';

part 'payment_transaction_cubit.freezed.dart';

part 'payment_transaction_state.dart';

@injectable
class PaymentTransactionCubit extends BaseCubit<PaymentTransactionBuildable,
    PaymentTransactionListenable> {
  PaymentTransactionCubit(this.paymentTransactionRepository)
      : super(PaymentTransactionBuildable()) {
    getController();
  }

  final PaymentTransactionRepository paymentTransactionRepository;

  Future<void> getController() async {
    try {
      final controller =
          currentState.transactionPagingController ?? getAdsController(status: 1);
      updateState((buildable) =>
          buildable.copyWith(transactionPagingController: controller));
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(currentState.transactionPagingController);
    }
  }

  PagingController<int, dynamic> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, dynamic>(
        firstPageKey: 1, invisibleItemsThreshold: 100);
    log.i(currentState.transactionPagingController);

    adController.addPageRequestListener(
      (pageKey) async {
        final adsList = await paymentTransactionRepository
            .getPaymentTransactions(pageSize: 20, pageIndex: pageKey);

        if (adsList.length <= 19) {
          adController.appendLastPage(adsList);
          log.i(currentState.transactionPagingController);
          return;
        }
        adController.appendPage(adsList, pageKey + 1);
        log.i(currentState.transactionPagingController);
      },
    );
    return adController;
  }
}

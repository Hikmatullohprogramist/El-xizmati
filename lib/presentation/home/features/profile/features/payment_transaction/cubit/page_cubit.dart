import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../common/core/base_cubit.dart';
import '../../../../../../../common/enum/enums.dart';
import '../../../../../../../data/repositories/transaction_repository.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.paymentTransactionRepository) : super(PageState()) {
    getController();
  }

  final PaymentTransactionRepository paymentTransactionRepository;

  Future<void> getController() async {
    try {
      final controller = states.controller ?? getAdsController(status: 1);
      updateState((state) => state.copyWith(controller: controller));
    } catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      log.i(states.controller);
    }
  }

  PagingController<int, dynamic> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, dynamic>(
        firstPageKey: 1, invisibleItemsThreshold: 100);
    log.i(states.controller);

    adController.addPageRequestListener(
      (pageKey) async {
        final adsList = await paymentTransactionRepository
            .getPaymentTransactions(pageSize: 20, pageIndex: pageKey);

        if (adsList.length <= 19) {
          adController.appendLastPage(adsList);
          log.i(states.controller);
          return;
        }
        adController.appendPage(adsList, pageKey + 1);
        log.i(states.controller);
      },
    );
    return adController;
  }
}

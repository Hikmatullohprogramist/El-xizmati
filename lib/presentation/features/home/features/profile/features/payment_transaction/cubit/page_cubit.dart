import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/data/repositories/transaction_repository.dart';

part 'page_cubit.freezed.dart';
part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._paymentTransactionRepository) : super(PageState()) {
    getController();
  }

  final PaymentTransactionRepository _paymentTransactionRepository;

  Future<void> getController() async {
    try {
      final controller = states.controller ?? getAdsController(status: 1);
      updateState((state) => state.copyWith(controller: controller));
    } catch (e, stackTrace) {
      logger.e(e.toString(), error: e, stackTrace: stackTrace);
      stateMessageManager.showErrorSnackBar(e.toString());
    } finally {
      logger.i(states.controller);
    }
  }

  PagingController<int, dynamic> getAdsController({
    required int status,
  }) {
    final adController = PagingController<int, dynamic>(
        firstPageKey: 1, invisibleItemsThreshold: 100);
    logger.i(states.controller);

    adController.addPageRequestListener(
      (pageKey) async {
        final adsList =
            await _paymentTransactionRepository.getPaymentTransactions(
          pageSize: 20,
          pageIndex: pageKey,
        );

        if (adsList.length <= 19) {
          adController.appendLastPage(adsList);
          logger.i(states.controller);
          return;
        }
        adController.appendPage(adsList, pageKey + 1);
        logger.i(states.controller);
      },
    );
    return adController;
  }
}

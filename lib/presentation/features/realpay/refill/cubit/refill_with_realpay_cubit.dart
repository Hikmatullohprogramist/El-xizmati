import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/repositories/real_pay_integration_repositroy.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'refill_with_realpay_cubit.freezed.dart';
part 'refill_with_realpay_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._realPayIntegrationRepository) : super(const PageState()) {
    getPaymentMerchantToken();
  }

  final RealPayIntegrationRepository _realPayIntegrationRepository;

  void hideLoading() {
    updateState((state) => state.copyWith(isLoading: false));
  }

  Future<void> getPaymentMerchantToken() async {
    _realPayIntegrationRepository
        .getPaymentMerchantToken()
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(
                loadingState: LoadingState.loading,
              ));
        })
        .onSuccess((data) {
          updateState((state) => state.copyWith(
                merchantToken: data?.merchantToken ?? "",
                loadingState: LoadingState.success,
              ));
        })
        .onError((error) {
          stateMessageManager.showErrorBottomSheet(error.toString());
          updateState((state) => state.copyWith(
                loadingState: LoadingState.error,
              ));
        })
        .onFinished(() {})
        .executeFuture();
  }

  String generatePaymentUrl() {
    return _realPayIntegrationRepository
        .generatePaymentUrl(states.merchantToken);
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/core/enum/enums.dart';
import 'package:El_xizmati/core/handler/future_handler_exts.dart';
import 'package:El_xizmati/data/repositories/merchant_repository.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';

part 'add_card_with_realpay_cubit.freezed.dart';
part 'add_card_with_realpay_state.dart';

@Injectable()
class AddCardWithRealpayCubit
    extends BaseCubit<AddCardWithRealpayState, AddCardWithRealpayEvent> {
  AddCardWithRealpayCubit(
    this._merchantRepository,
  ) : super(const AddCardWithRealpayState()) {
     getPaymentMerchantToken();
  }

  final MerchantRepository _merchantRepository;

  void hideLoading() {
    updateState((state) => state.copyWith(isLoading: false));
  }

  Future<void> getPaymentMerchantToken() async {
    _merchantRepository
        .getRealPayAddCardMerchantToken()
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
    return _merchantRepository.generateAddCardUrl(states.merchantToken);
  }
}

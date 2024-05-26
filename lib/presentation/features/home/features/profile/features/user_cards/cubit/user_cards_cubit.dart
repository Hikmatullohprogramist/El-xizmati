import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/datasource/network/responses/realpay/real_pay_card_response.dart';
import 'package:onlinebozor/data/repositories/card_repositroy.dart';
import 'package:onlinebozor/data/repositories/real_pay_integration_repositroy.dart';
import 'package:onlinebozor/data/repositories/user_repository.dart';
import 'package:onlinebozor/domain/models/card/user_card.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'user_cards_cubit.freezed.dart';
part 'user_cards_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(
    this._cardRepository,
    this._realPayIntegrationRepository,
    this._userRepository,
  ) : super(PageState()) {
    getUser();
    getDepositBalance();
    getAddedCards();
  }

  final CardRepository _cardRepository;
  final RealPayIntegrationRepository _realPayIntegrationRepository;
  final UserRepository _userRepository;

  Future<void> getUser() async {
    final userHiveObject = _userRepository.getSavedUser();
    updateState((state) => state.copyWith(
          userFullName: userHiveObject?.fullName ?? "",
        ));
  }

  Future<void> getDepositBalance() async {
    _cardRepository
        .getDepositBalance()
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(
                balanceState: LoadingState.loading,
              ));
        })
        .onSuccess((data) {
          updateState((state) => state.copyWith(
                depositBalance: data.amount ?? 0.0,
                balanceState: LoadingState.success,
              ));
        })
        .onError((error) {
          updateState((state) => state.copyWith(
                balanceState: LoadingState.error,
              ));
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> getAddedCards() async {
    _realPayIntegrationRepository
        .getAddedCards()
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(
                cardsState: LoadingState.loading,
              ));
        })
        .onSuccess((data) {
          updateState((state) => state.copyWith(
                addedCards: data,
                cardsState: LoadingState.success,
              ));
        })
        .onError((error) {
          logger.w("getAddedCards error = $error");
          updateState((state) => state.copyWith(
                cardsState: LoadingState.error,
              ));
        })
        .onFinished(() {})
        .executeFuture();
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/extensions/list_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/core/handler/future_handler_exts.dart';
import 'package:onlinebozor/data/datasource/network/responses/realpay/real_pay_card_response.dart';
import 'package:onlinebozor/data/repositories/card_repositroy.dart';
import 'package:onlinebozor/data/repositories/user_repository.dart';
import 'package:onlinebozor/domain/models/card/user_card.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/presentation/support/extensions/extension_message_exts.dart';

part 'user_cards_cubit.freezed.dart';
part 'user_cards_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(
    this._cardRepository,
    this._userRepository,
  ) : super(PageState()) {
    getUser();
    getDepositCardBalance();
    getAddedCards();
  }

  final CardRepository _cardRepository;
  final UserRepository _userRepository;

  void reload() {
    getDepositCardBalance();
    getAddedCards();
  }

  Future<void> getUser() async {
    final userHiveObject = _userRepository.getSavedUser();
    updateState((state) => state.copyWith(
          userFullName: userHiveObject?.fullName ?? "",
        ));
  }

  Future<void> getDepositCardBalance() async {
    _cardRepository
        .getDepositCardBalance()
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(
                depositState: LoadingState.loading,
              ));
        })
        .onSuccess((data) {
          updateState((state) => state.copyWith(
                depositBalance: data.amount ?? 0.0,
                depositState: LoadingState.success,
              ));
        })
        .onError((error) {
          updateState((state) => state.copyWith(
                depositState: LoadingState.error,
              ));
          if (error.isRequiredShowError) {
            stateMessageManager.showErrorBottomSheet(error.localizedMessage);
          }
        })
        .onFinished(() {})
        .executeFuture();
  }

  Future<void> getAddedCards() async {
    _cardRepository
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

  Future<void> removeCard(UserCard card) async {
    _cardRepository
        .removeCard(card.id)
        .initFuture()
        .onStart(() {})
        .onSuccess((data) {
          states.addedCards.removeIf((e) => e.cardId == card.id);
          updateState((state) => state.copyWith());
          stateMessageManager.showSuccessBottomSheet("Karta o'chirildi");
        })
        .onError((error) {
          stateMessageManager.showErrorBottomSheet(error.localizedMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }
}

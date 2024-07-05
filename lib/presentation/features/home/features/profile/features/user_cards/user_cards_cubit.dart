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
class UserCardsCubit extends BaseCubit<UserCardsState, UserCardsEvent> {
  UserCardsCubit(
    this._cardRepository,
    this._userRepository,
  ) : super(UserCardsState()) {
    getUser();
    getDepositCardBalance();
    getUserDebitCards();
  }

  final CardRepository _cardRepository;
  final UserRepository _userRepository;

  void reload() {
    getDepositCardBalance();
    getUserDebitCards();
  }

  Future<void> getUser() async {
    final user = await _userRepository.getSavedUser();
    updateState((state) => state.copyWith(
          userFullName: user?.fullName ?? "",
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

  Future<void> getUserDebitCards() async {
    _cardRepository
        .getUserDebitCards()
        .initFuture()
        .onStart(() {
          updateState((state) => state.copyWith(
                cardsState: LoadingState.loading,
              ));
        })
        .onSuccess((data) {
          updateState((state) => state.copyWith(
                debitCards: data,
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
          final cards = states.debitCards.map((e) => e.copyWith()).toList();
          cards.removeIf((e) => e.cardId == card.id);
          updateState((state) => state.copyWith(debitCards: cards));
          stateMessageManager.showSuccessSnackBar(Strings.cardDeletedMessage);
        })
        .onError((error) {
          stateMessageManager.showErrorSnackBar(error.localizedMessage);
        })
        .onFinished(() {})
        .executeFuture();
  }
}

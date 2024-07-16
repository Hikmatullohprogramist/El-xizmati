part of 'user_cards_cubit.dart';

@freezed
class UserCardsState with _$UserCardsState {
  const UserCardsState._();

  const factory UserCardsState({
    @Default("") String userFullName,
//
    @Default(LoadingState.loading) LoadingState depositState,
    @Default(0) double depositBalance,
//
    @Default(LoadingState.loading) LoadingState cardsState,
    @Default([]) List<RealPayCard> debitCards,
//
  }) = _UserCardsState;

  UserCard get depositCard => UserCard(
        id: "1",
        balance: depositBalance,
        cardHolder: userFullName,
        cardName: Strings.userCardDepositCardName,
        cardPan: Strings.userCardDepositCardPan,
        isDeposit: true,
        cardLogo: Assets.images.icCardDeposit,
      );

  List<UserCard> get cards {
    return debitCards
        .map(
          (e) => UserCard(
            id: e.cardId,
            balance: e.balance / 100,
            cardHolder: e.cardHolder,
            cardName: e.bankName,
            cardPan: e.maskedPan,
            isDeposit: false,
            cardLogo: e.isHumo
                ? Assets.images.icCardHumoWhite
                : Assets.images.icCardUzcardWhite,
          ),
        )
        .toList();
  }
}

@freezed
class UserCardsEvent with _$UserCardsEvent {
  const factory UserCardsEvent() = _UserCardsEvent;
}

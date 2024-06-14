enum BillingTransactionType {
  credit,
  debit,
  hold,
  holdCard,
  holdCardCanceled,
  creditCard,
  holdCanceled;

  static BillingTransactionType valueOrDefault(String? value) {
    if (value == null || value.isEmpty) return debit;

    BillingTransactionType.values.firstWhere((e) => e.name == "", orElse: () {
      return debit;
    });

    return BillingTransactionType.values.firstWhere(
      (e) => e.name.toUpperCase() == value.toUpperCase(),
      orElse: () {
        switch (value.toUpperCase()) {
          case "CREDIT":
            return credit;
          case "DEBIT":
            return debit;
          case "HOLD":
            return hold;
          case "HOLD_CARD":
            return holdCard;
          case "HOLD_CARD_CANCELED":
            return holdCardCanceled;
          case "CREDIT_CARD":
            return creditCard;
          case "HOLD_CANCELED":
            return holdCanceled;
          default:
            return debit;
        }
      },
    );
  }
}

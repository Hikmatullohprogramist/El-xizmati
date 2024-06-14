enum BillingTransactionAction {
  import,
  byWallet,
  byBank,
  pledge,
  canceledPledge,
  penalty,
  commission,
  returnedCommission,
  returnedPledge,
  returned,
  canceled,
  takenPledge,
  cancelTakenPledge,
  takenCommission,
  cancelTakenCommission,
  realpay,
  payment;

  static BillingTransactionAction valueOrDefault(String? value) {
    if (value == null || value.isEmpty) return payment;

    return BillingTransactionAction.values.firstWhere(
      (e) => e.name.toUpperCase() == value.toUpperCase(),
      orElse: () {
        switch (value.toUpperCase()) {
          case "IMPORT":
            return import;
          case "BY_WALLET":
            return byWallet;
          case "BY_BANK":
            return byBank;
          case "PLEDGE":
            return pledge;
          case "CANCELED_PLEDGE":
            return canceledPledge;
          case "PENALTY":
            return penalty;
          case "COMMISSION":
            return commission;
          case "RETURNED_COMMISSION":
            return returnedCommission;
          case "RETURNED_PLEDGE":
            return returnedPledge;
          case "RETURNED":
            return returned;
          case "CANCELED":
            return canceled;
          case "TAKEN_PLEDGE":
            return takenPledge;
          case "CANCEL_TAKEN_PLEDGE":
            return cancelTakenPledge;
          case "TAKEN_COMISSION":
            return takenCommission;
          case "CANCEL_TAKEN_COMISSION":
            return cancelTakenCommission;
          case "REALPAY":
            return realpay;
          case "PAYMENT":
            return payment;
          default:
            return payment;
        }
      },
    );
  }
}

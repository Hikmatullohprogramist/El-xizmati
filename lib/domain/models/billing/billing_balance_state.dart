enum BillingBalanceState {
  calculated,
  notCalculated,
  error,
  recalculated;

  static BillingBalanceState valueOrDefault(String? value) {
    if (value == null || value.isEmpty) return error;

    return BillingBalanceState.values.firstWhere(
      (e) => e.name.toUpperCase() == value.toUpperCase(),
      orElse: () {
        switch (value.toUpperCase()) {
          case "CALCULATED":
            return calculated;
          case "NOT_CALCULATED":
            return notCalculated;
          case "ERROR":
            return error;
          case "RECALCULATED":
            return recalculated;
          default:
            return error;
        }
      },
    );
  }
}

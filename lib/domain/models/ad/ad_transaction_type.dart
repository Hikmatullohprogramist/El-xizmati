enum AdTransactionType {
  sell,
  free,
  exchange,
  service,
  buy,
  buy_service;

  static AdTransactionType valueOrDefault(String? stringValue) {
    return AdTransactionType.values.firstWhere(
      (e) => e.name.toUpperCase() == stringValue?.toUpperCase(),
      orElse: () => AdTransactionType.sell,
    );
  }
}

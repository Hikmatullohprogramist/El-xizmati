enum AdType {
  product,
  service;

  static AdType valueOrDefault(String? stringValue) {
    return AdType.values.firstWhere(
      (e) => e.name.toUpperCase() == stringValue?.toUpperCase(),
      orElse: () => AdType.product,
    );
  }
}

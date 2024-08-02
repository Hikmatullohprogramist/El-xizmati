class IntentPlanPayment {
  IntentPlanPayment({
    required this.duration,
    required this.price,
    required this.per_month,
    required this.isSelected,
  });

  IntentPlanPayment copy() {
    return IntentPlanPayment(
      duration: duration,
      price: price,
      per_month: per_month,
      isSelected: isSelected,

    );
  }

  final int duration;
  num price;
  num per_month;
  bool isSelected;

  @override
  String toString() {
    return 'IntentPlanPaymentObject('
        'duration: $duration, '
        'price: $price, '
        'per_month: $per_month, '
        'isSelected: $isSelected,';
  }
}

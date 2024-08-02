class SmPlanPayment {
  SmPlanPayment({
    required this.id,
    required this.productId,
    required this.monthId,
    required this.monthlyPrice,
    required this.startingPrice,
    required this.contsStartingPrice,
    required this.startingPercentage,
    required this.totalPrice,
    required this.overtimePrice,
    required this.overtimePercentage,
    required this.isSelected,

  });

  SmPlanPayment copy() {
    return SmPlanPayment(
      id: id,
      productId: productId,
      monthId: monthId,
      monthlyPrice: monthlyPrice,
      startingPrice: startingPrice,
      startingPercentage: startingPercentage,
      totalPrice: totalPrice,
      overtimePrice: overtimePrice,
      overtimePercentage: overtimePercentage,
      isSelected: isSelected,
        contsStartingPrice: contsStartingPrice
    );
  }

  final int id;
  final int productId;
  final int monthId;
  num monthlyPrice;
  num startingPrice;
  final num contsStartingPrice;
  final num startingPercentage;
  final num totalPrice;
  final num overtimePrice;
  final num overtimePercentage;
  bool isSelected;

  @override
  String toString() {
    return 'SmPlanPaymentObject(id: $id, '
        'productId: $productId, '
        'monthId: $monthId, '
        'monthlyPrice: $monthlyPrice,'
        'startingPrice: $startingPrice,'
        'startingPercentage: $startingPercentage,'
        'constStartingPercentage: $contsStartingPrice,'
        'totalPrice: $totalPrice, '
        'overtimePrice: $overtimePrice, '
        'overtimePercentage: $overtimePercentage, '
        'isSelected: $isSelected, ';
  }
}

class SmPlanPaymentTable {
  SmPlanPaymentTable({
    required this.monthId,
    required this.monthlyPrice,
    required this.totalPrice,
    required this.datetime
  });

  SmPlanPaymentTable copy() {
    return SmPlanPaymentTable(
      monthId: monthId,
      monthlyPrice: monthlyPrice,
      totalPrice: totalPrice,
      datetime: datetime,
    );
  }


  final int monthId;
  num monthlyPrice;
  final num totalPrice;
  final DateTime datetime;


  @override
  String toString() {
    return 'SmPlanPaymentObject('
        'monthId: $monthId, '
        'monthlyPrice: $monthlyPrice,'
        'totalPrice: $totalPrice, '
        'dateTime: $datetime, '
      ;
  }
}

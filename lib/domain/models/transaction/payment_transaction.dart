class PaymentTransaction {
  int id;
  String payDate;
  String type;
  double amount;
  String payStatus;
  String payMethod;
  String payType;
  String note;

  PaymentTransaction({
    required this.id,
    required this.payDate,
    required this.type,
    required this.amount,
    required this.payStatus,
    required this.payMethod,
    required this.payType,
    required this.note,
  });
}

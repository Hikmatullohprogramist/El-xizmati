import 'package:onlinebozor/data/datasource/network/responses/transaction/payment_transaction_response.dart';
import 'package:onlinebozor/domain/models/transaction/payment_transaction.dart';

extension PaymentTransactionResponseMapper on PaymentTransactionResponse {
  PaymentTransaction toTransaction() {
    return PaymentTransaction(
      id: id,
      payDate: payDate ?? "",
      type: type ?? "",
      amount: amount ?? 0.0,
      payStatus: payStatus ?? "",
      payMethod: payMethod ?? "",
      payType: payType ?? "",
      note: note ?? "",
    );
  }
}

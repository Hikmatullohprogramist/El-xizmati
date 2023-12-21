

import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/responses/transaction/payment_transaction_response.dart';
import 'package:onlinebozor/data/services/payment_transaction_service.dart';

@LazySingleton()
class PaymentTransactionRepository{
   final PaymentTransactionService paymentTransactionService;

   PaymentTransactionRepository(this.paymentTransactionService);

   Future<List<dynamic>> getPaymentTransactions({required int pageSize,required pageIndex})async{
     final response = await paymentTransactionService.getPaymentTransaction(pageSize: pageSize, pageIndex: pageIndex);
     final transactionResponse = PaymentTransactionRootResponse.fromJson(response.data).data;
     return transactionResponse.results;
   }
}
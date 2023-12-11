import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/repositories/payment_transaction_repository.dart';

@LazySingleton(as: PaymentTransactionRepository)
class PaymentTransactionRepositoryImp extends PaymentTransactionRepository {}

import 'package:onlinebozor/domain/models/billing/billing_balance_state.dart';
import 'package:onlinebozor/domain/models/billing/billing_transaction_action.dart';
import 'package:onlinebozor/domain/models/billing/billing_transaction_type.dart';

class BillingTransaction {
  int id;
  int index;
  String payDate;
  BillingTransactionType transactionType;
  double amount;
  String payStatus;
  BillingTransactionAction transactionAction;
  BillingBalanceState balanceState;
  String note;

  BillingTransaction({
    required this.id,
    required this.index,
    required this.payDate,
    required this.transactionType,
    required this.amount,
    required this.payStatus,
    required this.transactionAction,
    required this.balanceState,
    required this.note,
  });

// 'CREDIT', 'DEBIT', 'HOLD', 'HOLD_CARD', 'HOLD_CARD_CANCELED',
// 'CREDIT_CARD', 'HOLD_CANCELED'.  type
//
// 'IMPORT', 'BY_WALLET', 'BY_BANK', 'PLEDGE', 'CANCELED_PLEDGE',
// 'PENALTY', 'COMMISSION', 'RETURNED_COMMISSION', 'RETURNED_PLEDGE',
// 'RETURNED', 'CANCELED', 'TAKEN_PLEDGE', 'CANCEL_TAKEN_PLEDGE',
// 'TAKEN_COMISSION', 'CANCEL_TAKEN_COMISSION',
// 'REALPAY', 'PAYMENT'.   doc type
//
// 'CALCULATED', 'NOT_CALCULATED',
// 'ERROR', 'RECALCULATED'.   saldo_state
}

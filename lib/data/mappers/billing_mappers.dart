import 'package:El_xizmati/data/datasource/network/responses/billing/billing_transaction_response.dart';
import 'package:El_xizmati/domain/models/billing/billing_balance_state.dart';
import 'package:El_xizmati/domain/models/billing/billing_transaction.dart';
import 'package:El_xizmati/domain/models/billing/billing_transaction_action.dart';
import 'package:El_xizmati/domain/models/billing/billing_transaction_type.dart';

extension BillingTransactionResponseMapper on BillingTransactionResponse {
  BillingTransaction toTransaction(int index) {
    return BillingTransaction(
      id: id,
      index: index,
      payDate: payDate ?? "",
      transactionType: BillingTransactionType.valueOrDefault(transactionType),
      amount: amount ?? 0.0,
      payStatus: payStatus ?? "",
      transactionAction:
          BillingTransactionAction.valueOrDefault(transactionAction),
      balanceState: BillingBalanceState.valueOrDefault(balanceState),
      note: note ?? "",
    );
  }
}

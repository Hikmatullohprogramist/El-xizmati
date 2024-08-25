import 'package:flutter/material.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/domain/models/billing/billing_transaction.dart';
import 'package:El_xizmati/presentation/support/extensions/resource_exts.dart';

class BillingTransactionWidget extends StatelessWidget {
  final BillingTransaction transaction;
  final VoidCallback onClicked;

  const BillingTransactionWidget({
    super.key,
    required this.transaction,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onClicked(),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  transaction.payDate.s(14).w(600),
                  SizedBox(width: 12),
                  Expanded(
                    child: transaction.transactionType
                        .getTransactionTypeLocalizedName()
                        .s(14)
                        .w(500)
                        // .c(transaction.transactionType.getTypeColor())
                        .copyWith(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.end,
                        ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: transaction.note
                        .s(12)
                        .w(500)
                        .copyWith(maxLines: 3, overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  transaction.transactionType
                      .getPaymentTypeLocalizedName()
                      .s(14)
                      .w(400),
                  SizedBox(width: 12),
                  Expanded(
                    child:
                        "${transaction.formattedAmount} ${Strings.currencyUzs}"
                            .toString()
                            .w(600)
                            .s(14)
                            .c(transaction.transactionType.getPriceColor())
                            .copyWith(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                            ),
                  ),
                ],
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

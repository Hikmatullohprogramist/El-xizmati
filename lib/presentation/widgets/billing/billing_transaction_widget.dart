import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/billing/billing_transaction.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/extensions/mask_formatters.dart';
import 'package:onlinebozor/presentation/widgets/image/rounded_cached_network_image_widget.dart';

class BillingTransactionWidget extends StatelessWidget {
  const BillingTransactionWidget({
    super.key,
    required this.transaction,
    required this.onClicked,
  });

  final BillingTransaction transaction;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onClicked(),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              transaction.index.toString().s(14).w(600),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  "type = ${transaction.transactionType.name} \n action = ${transaction.transactionAction.name} \n state = ${transaction.balanceState.name}"
                      .s(12)
                      .w(500),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      transaction.note.s(12).w(500),
                    ],
                  ),
                  SizedBox(height: 8),
                  transaction.payDate.w(500).s(12).c(context.textSecondary),
                  SizedBox(height: 8),
                  "${phoneMaskFormatter.formatDouble(transaction.amount)} ${Strings.currencyUzs}"
                      .toString()
                      .w(500)
                      .s(12)
                      .c(Color(0xFF41455E)),
                  SizedBox(height: 8),
                  SizedBox(height: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

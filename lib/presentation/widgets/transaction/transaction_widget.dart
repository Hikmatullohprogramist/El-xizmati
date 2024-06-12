import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/transaction/payment_transaction.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/extensions/mask_formatters.dart';
import 'package:onlinebozor/presentation/widgets/image/rounded_cached_network_image_widget.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    super.key,
    required this.transaction,
    required this.onClicked,
  });

  final PaymentTransaction transaction;
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
              Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    width: 1,
                    color: Color(0xFFDFE2E9),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (transaction.payMethod == "REALPAY")
                      Assets.images.realPay.svg()
                    else
                      RoundedCachedNetworkImage(
                        imageId: "",
                      )
                  ],
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.type == "ADS"
                        ? "Advertisement"
                        : transaction.type,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: Color(0xFF41455E),
                    ),
                  ),
                  SizedBox(height: 10),
                  transaction.payDate.w(500).s(12).c(context.textSecondary)
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  "${phoneMaskFormatter.formatDouble(transaction.amount)} ${Strings.currencyUzs}"
                      .toString()
                      .w(500)
                      .s(12)
                      .c(Color(0xFF41455E)),
                  SizedBox(height: 9),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child:
                        transaction.payStatus.w(500).s(10).c(Color(0xFF32B88B)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

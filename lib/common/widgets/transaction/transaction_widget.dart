import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/image/rounded_cached_network_image_widget.dart';
import 'package:onlinebozor/data/responses/transaction/payment_transaction_response.dart';

import '../../constants.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    super.key,
    required this.transaction,
  });

  final PaymentTransactionResponse transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: context.cardStrokeColor),
      ),
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
                if (transaction.pay_method == "REALPAY")
                  SvgPicture.asset('assets/images/real_pay.svg')
                else
                  RoundedCachedNetworkImage(imageId: Constants.baseUrlForImage)
              ],
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.type == "ADS" ? "Advertisement" : transaction.type,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Color(0xFF41455E),
                ),
              ),
              SizedBox(height: 10),
              transaction.pay_date.w(500).s(12).c(Color(0xFF9EABBE))
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              transaction.amount.toString().w(500).s(12).c(Color(0xFF41455E)),
              SizedBox(height: 9),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: transaction.pay_status.w(500).s(10).c(Color(0xFF32B88B)),
              )
            ],
          ),
        ],
      ),
    );
  }
}

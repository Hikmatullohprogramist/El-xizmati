import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/data/responses/transaction/payment_transaction_response.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants.dart';

class TransactionShimmer extends StatelessWidget {
  const TransactionShimmer({
    super.key,

  });


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Color(0xFFE5E9F3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Color(0xFFE8E6E8),
            highlightColor: Colors.grey[50]!,
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white
              ),
            ),
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 10),
             Shimmer.fromColors(
               baseColor: Color(0xFFE8E6E8),
               highlightColor: Colors.grey[50]!,
               child: Container(width: 100,height: 10,
                   decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(6)
               ),
               ),
             ),
              SizedBox(height: 12),
              Shimmer.fromColors(
                baseColor: Color(0xFFE8E6E8),
                highlightColor: Colors.grey[50]!,
                child: Container(width: 150,height: 10,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)
                  ),),
              )
            ],
          ),
          Spacer(),

        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/currency_extensions.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/button/common_button.dart';
import 'package:shimmer/shimmer.dart';

import '../../../domain/models/ad/ad.dart';
import '../../../domain/models/currency/currency.dart';
import '../../constants.dart';
import '../../gen/assets/assets.gen.dart';

class CartWidgetShimmer extends StatelessWidget {
  const CartWidgetShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Color(0xFFE5E9F3)),
      ),
      child: Row(
        children: [
          Shimmer.fromColors(
            baseColor: Color(0xFFE8E6E8),
            highlightColor: Colors.grey[50]!,
            child: Container(
              width: 80,
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(width: 0.50, color: Color(0xFFE5E9F3)),
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                Shimmer.fromColors(
                  baseColor: Color(0xFFE8E6E8),
                  highlightColor: Colors.grey[50]!,
                  child: Container(
                    width: 180,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Shimmer.fromColors(
                  baseColor: Color(0xFFE8E6E8),
                  highlightColor: Colors.grey[50]!,
                  child: Container(
                    width: 100,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Shimmer.fromColors(
                  baseColor: Color(0xFFE8E6E8),
                  highlightColor: Colors.grey[50]!,
                  child: Container(
                    width: 130,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),
              ])),
        ],
      ),
    );
  }
}

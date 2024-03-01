import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/responses/address/user_address_response.dart';

class UserAddressShimmer extends StatelessWidget {
  const UserAddressShimmer({
    super.key,

  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Color(0xFFE5E9F3)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
          },
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: EdgeInsets.only(left: 12, top: 12, right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[350]!,
                  highlightColor: Colors.grey[200]!,
                  child: Container(height: 14, width:80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3)
                  ),),
                ),
                SizedBox(height: 15),
                Shimmer.fromColors(
                  baseColor: Colors.grey[350]!,
                  highlightColor: Colors.grey[200]!,
                  child: Container(height: 14,
                    margin: EdgeInsets.only(right: 60),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3)
                    ),),
                ),
                SizedBox(height: 15),
                Shimmer.fromColors(
                  baseColor: Colors.grey[350]!,
                  highlightColor: Colors.grey[200]!,
                  child: Container(height: 14,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(3)
                    ),),
                ),
                SizedBox(height: 12),
                Shimmer.fromColors(
                  baseColor: Colors.grey[350]!,
                  highlightColor: Colors.grey[200]!,
                  child: Container(height: 14,
                    margin: EdgeInsets.only(right: 60),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3)
                    ),),
                ),
                SizedBox(height: 12),


              ],
            ),
          ),
        ),
      ),
    );
  }
}

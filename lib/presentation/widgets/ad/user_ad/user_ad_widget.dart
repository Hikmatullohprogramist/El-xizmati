import 'package:flutter/material.dart';
import 'package:onlinebozor/core/colors/color_extension.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/vibrator/vibrator_extension.dart';
import 'package:onlinebozor/domain/mappers/common_mapper_exts.dart';
import 'package:onlinebozor/presentation/utils/resource_exts.dart';
import 'package:onlinebozor/presentation/widgets/ad/list_price_text_widget.dart';
import 'package:onlinebozor/presentation/widgets/ad/user_ad/user_ad_stats_widget.dart';
import 'package:onlinebozor/presentation/widgets/image/rounded_cached_network_image_widget.dart';

import '../../../../domain/models/ad/user_ad.dart';

class UserAdWidget extends StatelessWidget {
  const UserAdWidget({
    super.key,
    required this.onActionClicked,
    required this.onItemClicked,
    required this.userAd,
  });

  final UserAd userAd;
  final VoidCallback onActionClicked;
  final VoidCallback onItemClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: context.primaryContainer,
        borderRadius: BorderRadius.circular(8),
        // border: Border.all(width: 1, color: Color(0xFFE5E9F3)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onItemClicked,
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: EdgeInsets.only(left: 12, top: 12, right: 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        RoundedCachedNetworkImage(
                          imageId: userAd.mainPhoto ?? "",
                          imageWidth: 130,
                          imageHeight: 100,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6),
                                bottomRight: Radius.circular(6),
                              ),
                              color: userAd.adTransactionType
                                  .getTransactionTypeColor(),
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 8,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                userAd.adTransactionType
                                    .getTransactionTypeLocalizedName()
                                    .w(400)
                                    .s(13)
                                    .c(context.colors.textPrimaryInverse)
                                    .copyWith(overflow: TextOverflow.ellipsis)
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 12),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        (userAd.name ?? "")
                            .w(600)
                            .s(14)
                            .c(Color(0xFF41455E))
                            .copyWith(
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                        SizedBox(height: 4),
                        (userAd.category?.name ?? "")
                            .w(500)
                            .s(14)
                            .c(Color(0xFF9EABBE))
                            .copyWith(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        SizedBox(height: 4),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: userAd.status.getColor().withOpacity(.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: userAd.status
                              .getLocalizedName()
                              .w(500)
                              .s(14)
                              .c(userAd.status.getColor())
                              .copyWith(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                        ),
                        SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: ListPriceTextWidget(
                            price: userAd.price ?? 0,
                            toPrice: userAd.toPrice ?? 0,
                            fromPrice: userAd.fromPrice ?? 0,
                            currency: userAd.currency.toCurrency(),
                          ),
                        ),
                      ],
                    )),
                    SizedBox(width: 12),
                  ],
                ),
                SizedBox(height: 2),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AdStatsWidget(
                      icon: Assets.images.icViewCount,
                      count: userAd.viewedCount,
                    ),
                    SizedBox(width: 8),
                    AdStatsWidget(
                      icon: Assets.images.icFavoriteRemove,
                      count: userAd.selectedCount,
                    ),
                    SizedBox(width: 6),
                    AdStatsWidget(
                      icon: Assets.images.icCall,
                      count: userAd.phoneViewedCount,
                    ),
                    SizedBox(width: 6),
                    AdStatsWidget(
                      icon: Assets.images.icAdMessage,
                      count: userAd.messageViewedCount,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              onActionClicked();
                              vibrateAsHapticFeedback();
                            },
                            icon: Assets.images.icThreeDotVertical
                                .svg(width: 24, height: 24),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 6)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

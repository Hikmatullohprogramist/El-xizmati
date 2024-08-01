import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/domain/mappers/common_mapper_exts.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/extensions/resource_exts.dart';
import 'package:onlinebozor/presentation/widgets/ad/list_price_text_widget.dart';
import 'package:onlinebozor/presentation/widgets/ad/user_ad/user_ad_stats_widget.dart';
import 'package:onlinebozor/presentation/widgets/divider/custom_divider.dart';
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onItemClicked,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: EdgeInsets.only(left: 12, top: 12, right: 0),
          child: Column(
            children: [
              if (userAd.hasModeratorNote()) ..._buildModeratorNoteWidgets(),
              Row(
                children: [
                  Stack(
                    children: [
                      RoundedCachedNetworkImage(
                        imageId: userAd.mainPhoto ?? "",
                        width: 130,
                        height: 100,
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
                                  .c(context.textPrimaryInverse)
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
                      (userAd.name ?? "").w(600).s(14).copyWith(
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                      SizedBox(height: 4),
                      (userAd.category?.name ?? "")
                          .w(500)
                          .s(14)
                          .c(context.textSecondary)
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
                  Flexible(
                    child: AdStatsWidget(
                      icon: Assets.images.icViewCount,
                      count: userAd.viewedCount,
                    ),
                  ),
                  SizedBox(width: 6),
                  Flexible(
                    child: AdStatsWidget(
                      icon: Assets.images.icFavoriteRemove,
                      count: userAd.selectedCount,
                    ),
                  ),
                  SizedBox(width: 6),
                  Flexible(
                    child: AdStatsWidget(
                      icon: Assets.images.icCall,
                      count: userAd.phoneViewedCount,
                    ),
                  ),
                  SizedBox(width: 6),
                  Flexible(
                    child: AdStatsWidget(
                      icon: Assets.images.icAdMessage,
                      count: userAd.messageViewedCount,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            onActionClicked();
                            HapticFeedback.lightImpact();
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
    );
  }

  List<Widget> _buildModeratorNoteWidgets() {
    return [
      Row(
        children: [
          Expanded(
            child: userAd.moderatorNote!
                .s(15)
                .w(500)
                .c(Color(0xFFFB577C))
                .copyWith(textAlign: TextAlign.start),
          ),
        ],
      ),
      SizedBox(height: 12),
      CustomDivider(thickness: 0.75, endIndent: 12),
      SizedBox(height: 12),
    ];
  }
}

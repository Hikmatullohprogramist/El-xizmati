import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/vibrator/vibrator_extension.dart';
import 'package:onlinebozor/common/widgets/ad/list_price_text_widget.dart';
import 'package:onlinebozor/common/widgets/ad/user_ad/user_ad_stats_widget.dart';
import 'package:onlinebozor/domain/mappers/ad_enum_mapper.dart';

import '../../../../domain/models/ad/user_ad.dart';
import '../../../constants.dart';

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
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Color(0xFFE5E9F3)),
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
                      Container(
                        width: 110,
                        height: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border:
                              Border.all(width: 0.50, color: Color(0xFFE5E9F3)),
                          color: Color(0xFFF6F7FC),
                        ),
                        child: _getAdImageWidget(),
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
                                  maxLines: 3, overflow: TextOverflow.ellipsis),
                          SizedBox(height: 4),
                          (userAd.category?.name ?? "*")
                              .w(500)
                              .s(14)
                              .c(Color(0xFF9EABBE))
                              .copyWith(
                                  maxLines: 1, overflow: TextOverflow.ellipsis),
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
                      ))
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
                                icon: Assets.images.icMoreVert
                                    .svg(width: 24, height: 24)),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 6)
                ],
              ),
            )),
      ),
    );
  }

  Widget _getAdImageWidget() {
    return CachedNetworkImage(
      imageUrl: "${Constants.baseUrlForImage}${userAd.mainPhoto ?? ""}",
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.colorBurn),
          ),
        ),
      ),
      placeholder: (context, url) => Center(),
      errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
    );
  }
}

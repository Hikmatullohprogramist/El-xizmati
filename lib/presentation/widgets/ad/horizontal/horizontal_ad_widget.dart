import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/domain/mappers/common_mapper_exts.dart';
import 'package:onlinebozor/domain/models/ad/ad.dart';
import 'package:onlinebozor/domain/models/ad/ad_priority_level.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/widgets/ad/ad_status_widget.dart';
import 'package:onlinebozor/presentation/widgets/ad/ad_type_widget.dart';
import 'package:onlinebozor/presentation/widgets/ad/list_ad_author_type_widget.dart';
import 'package:onlinebozor/presentation/widgets/ad/list_ad_property_widget.dart';
import 'package:onlinebozor/presentation/widgets/ad/list_price_text_widget.dart';
import 'package:onlinebozor/presentation/widgets/ad/view_count_widget.dart';
import 'package:onlinebozor/presentation/widgets/favorite/ad_cart_buy_widget.dart';
import 'package:onlinebozor/presentation/widgets/favorite/ad_favorite_widget.dart';
import 'package:onlinebozor/presentation/widgets/image/rounded_cached_network_image_widget.dart';

class HorizontalAdWidget extends StatelessWidget {
  const HorizontalAdWidget({
    super.key,
    required this.ad,
    required this.onItemClicked,
    required this.onFavoriteClicked,
    required this.onCartClicked,
    required this.onBuyClicked,
  });

  final Ad ad;
  final Function(Ad ad) onItemClicked;
  final Function(Ad ad) onFavoriteClicked;
  final Function(Ad ad) onCartClicked;
  final Function(Ad ad) onBuyClicked;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onItemClicked(ad);
      },
      child: SizedBox(
        height: 342,
        width: 140,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                RoundedCachedNetworkImage(
                  imageId: ad.photo,
                  width: 140,
                  height: 140,
                ),
                AppAdStatusWidget(adStatus: AdPriorityLevel.standard),
                Align(
                  alignment: Alignment.topRight,
                  child: AdFavoriteWidget(
                    isSelected: ad.isFavorite,
                    onClicked: () => onFavoriteClicked(ad),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: AdTypeWidget(adType: ad.transactionType.adType()),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: ViewCountWidget(viewCount: ad.viewCount),
                ),
              ],
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 32,
              child: (ad.name)
                  .w(400)
                  .s(13)
                  .c(context.textPrimary)
                  .copyWith(maxLines: 2)
                  .copyWith(maxLines: 2, overflow: TextOverflow.ellipsis),
            ),
            SizedBox(height: 6),
            ListPriceTextWidget(
              price: ad.price,
              toPrice: ad.toPrice,
              fromPrice: ad.fromPrice,
              currency: ad.currencyCode,
            ),
            SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Assets.images.icLocation.svg(width: 12, height: 12),
                SizedBox(width: 4),
                Expanded(
                  child: "${ad.regionName} ${ad.districtName}"
                      .w(400)
                      .s(12)
                      .c(context.textSecondary)
                      .copyWith(
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                )
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListAdAuthorTypeChipWidget(
                  isHorizontal: true,
                  adAuthorType: ad.authorType,
                ),
                SizedBox(width: 2),
                ListAdPropertyWidget(
                  isHorizontal: true,
                  adPropertyType: ad.itemCondition,
                )
              ],
            ),
            SizedBox(height: 6),
            AdCartBuyWidget(
              height: 32,
              isAddedCart: false,
              onCartClicked: () => onCartClicked(ad),
              onBuyClicked: () => onBuyClicked(ad),
            ),
          ],
        ),
      ),
    );
  }
}

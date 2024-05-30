import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/domain/mappers/common_mapper_exts.dart';
import 'package:onlinebozor/domain/models/ad/ad.dart';
import 'package:onlinebozor/presentation/widgets/ad/ad_status_widget.dart';
import 'package:onlinebozor/presentation/widgets/ad/list_ad_property_widget.dart';
import 'package:onlinebozor/presentation/widgets/ad/list_price_text_widget.dart';
import 'package:onlinebozor/presentation/widgets/ad/view_count_widget.dart';
import 'package:onlinebozor/presentation/widgets/favorite/ad_cart_buy_widget.dart';
import 'package:onlinebozor/presentation/widgets/favorite/ad_favorite_widget.dart';
import 'package:onlinebozor/presentation/widgets/image/rounded_cached_network_image_widget.dart';

import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import '../ad_type_widget.dart';
import '../list_ad_author_type_widget.dart';

class VerticalAdWidget extends StatelessWidget {
  VerticalAdWidget({
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
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onItemClicked(ad);
        },
        borderRadius: BorderRadius.all(Radius.circular(6)),
        child: SizedBox(
          // height: MediaQuery.of(context).size.height,
          // width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  RoundedCachedNetworkImage(
                    imageId: ad.photo,
                    imageHeight: 140,
                  ),
                  AppAdStatusWidget(adStatus: ad.priorityLevel),
                  Align(
                    alignment: Alignment.topRight,
                    child: AdFavoriteWidget(
                      isSelected: ad.isFavorite,
                      invoke: () => onFavoriteClicked(ad),
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
              SizedBox(height: 8),
              SizedBox(
                height: 32,
                child: (ad.name)
                    .w(400)
                    .s(13)
                    .c(context.textPrimary)
                    .copyWith(maxLines: 2, overflow: TextOverflow.ellipsis),
              ),
              SizedBox(height: 6),
              ListPriceTextWidget(
                price: ad.price,
                toPrice: ad.toPrice,
                fromPrice: ad.fromPrice,
                currency: ad.currencyCode,
              ),
              SizedBox(height: 6),
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
              SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListAdAuthorTypeChipWidget(
                    adAuthorType: ad.authorType,
                    isHorizontal: false,
                  ),
                  SizedBox(width: 5),
                  ListAdPropertyWidget(
                    adPropertyType: ad.itemCondition,
                    isHorizontal: false,
                  )
                ],
              ),
              SizedBox(height: 4),
              AdCartBuyWidget(
                height: 32,
                isAddedCart: false,
                onCartClicked: () => onCartClicked(ad),
                onBuyClicked: () => onBuyClicked(ad),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

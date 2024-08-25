import 'package:flutter/material.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/presentation/widgets/ad/list_price_text_widget.dart';
import 'package:El_xizmati/presentation/widgets/favorite/ad_favorite_widget.dart';
import 'package:El_xizmati/presentation/widgets/image/rounded_cached_network_image_widget.dart';

import '../../../../domain/models/ad/ad.dart';

class TopRatedAdWidget extends StatelessWidget {
  const TopRatedAdWidget({
    super.key,
    required this.onOnClickBuyClicked,
    required this.onFavoriteClicked,
    required this.onItemClicked,
    required this.ad,
  });

  final Ad ad;
  final Function(Ad ad) onOnClickBuyClicked;
  final Function(Ad ad) onFavoriteClicked;
  final Function(Ad ad) onItemClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 248,
      padding: EdgeInsets.only(left: 12, top: 12, right: 0),
      decoration: _getBackgroundGradient(),
      child: InkWell(
          onTap: () {
            onItemClicked(ad);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _getAdImageWidget(),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _getAdNameWidget(context),
                        SizedBox(height: 8),
                        ListPriceTextWidget(
                          price: ad.price,
                          toPrice: ad.toPrice,
                          fromPrice: ad.fromPrice,
                          currency: ad.currencyCode,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                ],
              ),
              SizedBox(height: 4),
              _getActionItems(),
              SizedBox(height: 8)
            ],
          )),
    );
  }

  Widget _getAdImageWidget() {
    return RoundedCachedNetworkImage(
      imageId: ad.photo,
      width: 72,
      height: 72,
    );
  }

  Decoration _getBackgroundGradient() {
    return ShapeDecoration(
      gradient: LinearGradient(
        begin: Alignment(0, -1),
        end: Alignment(1, 1),
        colors: const [Color(0xFF9570FF), Color(0xFFF0C49A)],
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.50, color: Color(0xFFB9A0FF)),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _getAdNameWidget(BuildContext context) {
    return (ad.name)
        .w(500)
        .s(13)
        .c(context.textPrimaryInverse)
        .copyWith(maxLines: 3, overflow: TextOverflow.ellipsis);
  }

  Widget _getActionItems() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {
            onOnClickBuyClicked(ad);
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Strings.adBuyByOneClick
                .w(500)
                .s(13)
                .c(Color(0xFF5C6AC3))
                .copyWith(textAlign: TextAlign.center),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            AdFavoriteWidget(
              isSelected: ad.isFavorite,
              onClicked: () => onFavoriteClicked(ad),
            ),
            SizedBox(width: 6)
          ],
        )
      ],
    );
  }
}

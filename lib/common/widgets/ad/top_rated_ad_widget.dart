import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/ad/list_price_text_widget.dart';
import 'package:onlinebozor/common/widgets/favorite/ad_favorite_widget.dart';

import '../../../domain/models/ad/ad.dart';
import '../../constants.dart';
import '../../vibrator/vibrator_extension.dart';

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
      padding: EdgeInsets.only(left: 16, top: 16, right: 0),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _getAdNameWidget(context),
                        ListPriceTextWidget(
                          price: ad.price,
                          toPrice: ad.toPrice,
                          fromPrice: ad.fromPrice,
                          currency: ad.currency,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              _getActionItems(),
              SizedBox(height: 8)
            ],
          )),
    );
  }

  Widget _getAdImageWidget() {
    return SizedBox(
      width: 72,
      height: 72,
      child: CachedNetworkImage(
        imageUrl: "${Constants.baseUrlForImage}${ad.photo}",
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
                colorFilter:
                    ColorFilter.mode(Colors.white, BlendMode.colorBurn)),
          ),
        ),
        placeholder: (context, url) => Center(),
        errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
      ),
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
        .c(context.colors.textPrimaryInverse)
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
              isSelected: ad.favorite,
              invoke: () => onFavoriteClicked(ad),
            ),
            SizedBox(width: 6)
          ],
        )
      ],
    );
  }
}

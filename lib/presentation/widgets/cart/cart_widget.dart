import 'package:flutter/material.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/widgets/button/custom_elevated_button.dart';
import 'package:El_xizmati/presentation/widgets/divider/custom_divider.dart';
import 'package:El_xizmati/presentation/widgets/favorite/order_ad_favorite_widget.dart';
import 'package:El_xizmati/presentation/widgets/favorite/order_ad_remove_widget.dart';
import 'package:El_xizmati/presentation/widgets/image/rounded_cached_network_image_widget.dart';

import '../../../domain/models/ad/ad.dart';
import '../ad/list_price_text_widget.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({
    super.key,
    required this.ad,
    required this.onDeleteClicked,
    required this.onFavoriteClicked,
    required this.onProductClicked,
    required this.onOrderClicked,
  });

  final Ad ad;
  final Function(Ad ad) onDeleteClicked;
  final Function(Ad ad) onFavoriteClicked;
  final Function(Ad ad) onProductClicked;
  final Function(Ad ad) onOrderClicked;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onProductClicked(ad),
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: EdgeInsets.only(left: 12, right: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ad.sellerName.s(16).w(600).copyWith(
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              CustomDivider(thickness: 0.5),
              SizedBox(height: 10),
              Row(
                children: [
                  RoundedCachedNetworkImage(
                    imageId: ad.photo,
                    width: 120,
                    height: 80,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ad.name.w(600).s(14).copyWith(
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                        SizedBox(height: 4),
                        ad.categoryName
                            .w(500)
                            .s(14)
                            .c(context.textSecondary)
                            .copyWith(
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                        SizedBox(height: 4),
                        ListPriceTextWidget(
                          price: ad.price,
                          toPrice: ad.toPrice,
                          fromPrice: ad.fromPrice,
                          currency: ad.currencyCode,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                ],
              ),
              SizedBox(height: 12),
              CustomDivider(thickness: 0.5),
              SizedBox(height: 12),
              Row(
                children: [
                  OrderAdFavoriteWidget(
                    isFavorite: ad.isFavorite,
                    onClicked: () => onFavoriteClicked(ad),
                  ),
                  SizedBox(width: 12),
                  OrderAdRemoveWidget(
                    onClicked: () => onDeleteClicked(ad),
                  ),
                  SizedBox(width: 20),
                  Flexible(
                    flex: 4,
                    child: CustomElevatedButton(
                      buttonHeight: 32,
                      textSize: 12,
                      text: Strings.cartOrderCreate,
                      onPressed: () => onOrderClicked(ad),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12)
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/common/widgets/divider/custom_diverder.dart';
import 'package:onlinebozor/common/widgets/favorite/order_ad_favorite_widget.dart';
import 'package:onlinebozor/common/widgets/favorite/order_ad_remove_widget.dart';
import 'package:onlinebozor/common/widgets/image/rounded_cached_network_image_widget.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: context.primaryContainer,
        borderRadius: BorderRadius.circular(8),
        // border: Border.all(width: 1, color: Color(0xFFE5E9F3)),
      ),
      child: Material(
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
                      imageWidth: 120,
                      imageHeight: 80,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ad.name.w(600).s(14).c(Color(0xFF41455E)).copyWith(
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                          SizedBox(height: 4),
                          ad.categoryName
                              .w(500)
                              .s(14)
                              .c(Color(0xFF9EABBE))
                              .copyWith(
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                          SizedBox(height: 4),
                          ListPriceTextWidget(
                            price: ad.price ?? 0,
                            toPrice: ad.toPrice ?? 0,
                            fromPrice: ad.fromPrice ?? 0,
                            currency: ad.currency,
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
                        text: Strings.cartMakeOrder,
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/data/datasource/network/responses/user_order/user_order_response.dart';
import 'package:onlinebozor/presentation/support/extensions/resource_exts.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/divider/custom_diverder.dart';

import '../image/rounded_cached_network_image_widget.dart';

class UserOrderWidget extends StatelessWidget {
  const UserOrderWidget({
    super.key,
    required this.order,
    required this.onClicked,
    required this.onCancelClicked,
    required this.onMoreClicked,
  });

  final UserOrder order;
  final VoidCallback onClicked;
  final VoidCallback onCancelClicked;
  final VoidCallback onMoreClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(8),
        border:
            Border.all(width: 1, color: context.cardStrokeColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(6),
          child: Container(
            padding: EdgeInsets.only(left: 12, right: 12),
            child: Column(
              children: [
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: "№ ${order.orderId}".s(16).w(600).copyWith(
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                      decoration: BoxDecoration(
                        color: order.orderStatus.getColor().withOpacity(.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: (order.orderStatus.getLocalizedName() ?? "")
                          .s(13)
                          .w(400)
                          .c(order.orderStatus.getColor()),
                    ),
                    // SizedBox(width: 8),
                    // Assets.images.icThreeDotVertical.svg()
                  ],
                ),
                SizedBox(height: 12),
                CustomDivider(thickness: 0.5),
                SizedBox(height: 10),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RoundedCachedNetworkImage(
                          imageId: order.mainPhoto,
                          imageWidth: 120,
                          imageHeight: 80,
                        ),
                      ],
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child:
                                    (order.products?.first.product?.name ?? "")
                                        .toString()
                                        .w(600)
                                        .s(13)
                                        .copyWith(
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                              )
                            ],
                          ),
                          SizedBox(height: 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              "${Strings.commonDate}:"
                                  .w(400)
                                  .s(13)
                                  .c(context.textPrimary),
                              SizedBox(width: 8),
                              (order.createdAt ?? "")
                                  .toString()
                                  .w(500)
                                  .s(13)
                                  .copyWith(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                            ],
                          ),
                          SizedBox(height: 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              "${Strings.commonPrice}:"
                                  .w(400)
                                  .s(13)
                                  .c(context.textPrimary),
                              SizedBox(width: 6),
                              order.formattedPrice.w(500).s(13).copyWith(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                            ],
                          ),
                          SizedBox(height: 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              "${Strings.commonQuantity}:"
                                  .w(400)
                                  .s(13)
                                  .c(context.textPrimary),
                              SizedBox(width: 6),
                              (order.firstProduct?.quantity ?? "")
                                  .toString()
                                  .w(500)
                                  .s(13)
                                  .copyWith(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                            ],
                          ),
                          SizedBox(height: 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              "${Strings.commonTotalCost}:"
                                  .w(400)
                                  .s(13)
                                  .c(context.textPrimary),
                              SizedBox(width: 6),
                              order.formattedTotalSum.w(500).s(13).copyWith(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                            ],
                          ),
                          SizedBox(height: 3),
                          (order.seller?.name ?? "")
                              .toString()
                              .w(500)
                              .s(13)
                              .copyWith(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                          SizedBox(height: 6),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                CustomDivider(thickness: 0.5),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        buttonHeight: 32,
                        textSize: 12,
                        text: Strings.commonCancel,
                        isEnabled: order.isCanCancel,
                        backgroundColor: Colors.red.shade400,
                        onPressed: () => onCancelClicked(),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: CustomElevatedButton(
                        buttonHeight: 32,
                        textSize: 12,
                        text: Strings.commonMore,
                        backgroundColor: StaticColors.buttonColor,
                        onPressed: () => onMoreClicked(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}

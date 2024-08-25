import 'package:flutter/material.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/domain/models/order/user_order.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/support/extensions/resource_exts.dart';
import 'package:El_xizmati/presentation/widgets/divider/custom_divider.dart';
import 'package:El_xizmati/presentation/widgets/image/rounded_cached_network_image_widget.dart';

class UserOrderWidget extends StatelessWidget {
  const UserOrderWidget({
    super.key,
    required this.order,
    required this.onClicked,
  });

  final UserOrder order;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onClicked(),
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
                      color: order.status.color().withOpacity(.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: (order.status.getLocalizedName())
                        .s(13)
                        .w(400)
                        .c(order.status.color()),
                  ),
                  SizedBox(width: 8),
                  Assets.images.icThreeDotVertical.svg()
                ],
              ),
              SizedBox(height: 12),
              CustomDivider(thickness: 0.5),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: (order.seller?.name ?? "")
                        .toString()
                        .w(500)
                        .s(13)
                        .copyWith(
                          textAlign: TextAlign.left,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                  ),
                ],
              ),
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
                        width: 120,
                        height: 80,
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
                              child: (order.firstProductName)
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
                        SizedBox(height: 6),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              CustomDivider(thickness: 0.5),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  "${Strings.commonTotalCost}:"
                      .w(400)
                      .s(13)
                      .c(context.textPrimary),
                  SizedBox(width: 6),
                  order.formattedTotalSum.w(500).s(14).copyWith(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                ],
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}

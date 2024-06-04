import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/data/datasource/network/responses/user_order/user_order_response.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/extensions/resource_exts.dart';
import 'package:onlinebozor/presentation/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/divider/custom_divider.dart';
import 'package:onlinebozor/presentation/widgets/image/rounded_cached_network_image_widget.dart';

import 'user_order_info_cubit.dart';

@RoutePage()
class UserOrderInfoPage extends BasePage<UserOrderInfoCubit, UserOrderInfoState,
    UserOrderInfoEvent> {
  final UserOrder order;

  const UserOrderInfoPage({
    super.key,
    required this.order,
  });

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(order);
  }

  @override
  Widget onWidgetBuild(BuildContext context, UserOrderInfoState state) {
    return Material(
      child: SizedBox(
        width: double.infinity,
        // height: MediaQuery.sizeOf(context).height * .9,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                color: context.bottomSheetColor,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      BottomSheetTitle(
                        title: "№ ${order.orderId}",
                        onCloseClicked: () {
                          context.router.pop();
                        },
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 12, right: 12),
                        child: Column(
                          children: [
                            SizedBox(height: 12),
                            CustomDivider(thickness: 0.5),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                RoundedCachedNetworkImage(
                                  imageId: order.mainPhoto,
                                  imageWidth: 120,
                                  imageHeight: 80,
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: (order.products?.first
                                                        .product?.name ??
                                                    "")
                                                .toString()
                                                .w(600)
                                                .s(13)
                                                .copyWith(
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 3),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          "${Strings.commonPrice}:"
                                              .w(400)
                                              .s(13)
                                              .c(context.textPrimary),
                                          SizedBox(width: 6),
                                          order.formattedPrice
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          "${Strings.commonTotalCost}:"
                                              .w(400)
                                              .s(13)
                                              .c(context.textPrimary),
                                          SizedBox(width: 6),
                                          order.formattedTotalSum
                                              .w(500)
                                              .s(13)
                                              .copyWith(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 6, horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: order.orderStatus
                                        .color()
                                        .withOpacity(.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: (order.orderStatus.getLocalizedName())
                                      .s(13)
                                      .w(400)
                                      .c(order.orderStatus.color()),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 6,
                                    horizontal: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: order.isCanCancel
                                        ? Colors.transparent
                                        : Color(0xFFF79500).withOpacity(.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: (order.getLocalizedCancelComment())
                                      .s(13)
                                      .w(400)
                                      .c(Color(0xFFF79500)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 86),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(16, 12, 16, 20),
                child: CustomElevatedButton(
                  text: Strings.commonClose,
                  onPressed: () {
                    context.router.pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

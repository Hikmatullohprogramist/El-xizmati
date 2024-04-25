import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/controller/controller_exts.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/common/widgets/divider/custom_diverder.dart';
import 'package:onlinebozor/common/widgets/image/rounded_cached_network_image_widget.dart';
import 'package:onlinebozor/data/responses/user_order/user_order_response.dart';
import 'package:onlinebozor/domain/mappers/common_mapper_exts.dart';
import 'package:onlinebozor/presentation/home/features/profile/features/user_orders/features/user_order_cancel/cubit/page_cubit.dart';
import 'package:onlinebozor/presentation/utils/resource_exts.dart';

@RoutePage()
class UserOrderInfoPage extends BasePage<PageCubit, PageState, PageEvent> {
  UserOrderInfoPage({
    super.key,
    required this.order,
  });

  final UserOrder order;

  final TextEditingController commentController = TextEditingController();

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(order);
  }

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.onBackAfterCancel:
        context.router.pop(cubit(context).states.userOrder!);
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    commentController.updateOnRestore(state.cancelComment);

    return SizedBox(
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
              color: context.bottomNavigationColor,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: (order.products?.first.product
                                                      ?.name ??
                                                  "")
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        "${Strings.commonDate}:"
                                            .w(400)
                                            .s(13)
                                            .c(context.colors.textPrimary),
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
                                            .c(context.colors.textPrimary),
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
                                            .c(context.colors.textPrimary),
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
                                            .c(context.colors.textPrimary),
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
                                      .getColor()
                                      .withOpacity(.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: (order.orderStatus.getLocalizedName())
                                    .s(13)
                                    .w(400)
                                    .c(order.orderStatus.getColor()),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: Color(0xFFF79500).withOpacity(.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child:
                                    (order.cancelNote?.getCancelComment() ?? "")
                                        .s(13)
                                        .w(400)
                                        .c(Color(0xFFF79500)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 72),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
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
    );
  }
}

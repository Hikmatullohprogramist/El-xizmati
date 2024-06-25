import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/data/datasource/network/responses/user_order/user_order_response.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_orders/features/user_order_cancel/user_order_cancel_page.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/extensions/platform_sizes.dart';
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
                    title: "№ ${state.actualOrder.orderId}",
                    onCloseClicked: () {
                      context.router.pop(state.updatedOrder);
                    },
                  ),
                  _buildProductBlock(context, state),
                  SizedBox(height: 8),
                  _buildActions(context, state),
                  SizedBox(height: bottomSheetBottomPadding),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildProductBlock(BuildContext context, UserOrderInfoState state) {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12),
      child: Column(
        children: [
          SizedBox(height: 12),
          CustomDivider(thickness: 0.5),
          SizedBox(height: 10),
          Row(
            children: [
              RoundedCachedNetworkImage(
                imageId: state.actualOrder.mainPhoto,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: (state.actualOrder.firstInfo?.name ?? "")
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
                        (state.actualOrder.createdAt ?? "")
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
                        state.actualOrder.formattedPrice.w(500).s(13).copyWith(
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
                        (state.actualOrder.firstProduct?.quantity ?? "")
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
                        state.actualOrder.formattedTotalSum.w(500).s(13).copyWith(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                      ],
                    ),
                    SizedBox(height: 3),
                    (state.actualOrder.seller?.name ?? "").toString().w(500).s(13).copyWith(
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
                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                decoration: BoxDecoration(
                  color: state.actualOrder.orderStatus.color().withOpacity(.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: (state.actualOrder.orderStatus.getLocalizedName())
                    .s(13)
                    .w(400)
                    .c(state.actualOrder.orderStatus.color()),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  color: state.actualOrder.isCanCancel
                      ? Colors.transparent
                      : Color(0xFFF79500).withOpacity(.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: (state.actualOrder.getLocalizedCancelComment())
                    .s(13)
                    .w(400)
                    .c(Color(0xFFF79500)),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context, UserOrderInfoState state) {
    return Column(
      children: [
        if (state.actualOrder.isCanCancel)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: CustomElevatedButton(
              text: Strings.commonCancel,
              isEnabled: state.actualOrder.isCanCancel,
              backgroundColor: Colors.red.shade400,
              onPressed: () {
                _showOrderCancelPage(context, order);
              },
            ),
          ),
        if (state.actualOrder.isCanCancel) SizedBox(height: 8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CustomElevatedButton(
            text: Strings.commonClose,
            onPressed: () {
              context.router.pop(state.updatedOrder);
            },
          ),
        ),
      ],
    );
  }

  Future<void> _showOrderCancelPage(
    BuildContext context,
    UserOrder order,
  ) async {
    final cancelledOrder = await showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => UserOrderCancelPage(order: order),
    );

    if (cancelledOrder != null && cancelledOrder is UserOrder) {
      cubit(context).updateCancelledOrder(cancelledOrder);
    }
  }
}

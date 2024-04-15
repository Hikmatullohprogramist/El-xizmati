import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/static_colors.dart';
import 'package:onlinebozor/common/extensions/currency_extensions.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/vibrator/vibrator_extension.dart';
import 'package:onlinebozor/common/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/common/widgets/favorite/order_ad_favorite_widget.dart';
import 'package:onlinebozor/common/widgets/order/create_order_shimmer.dart';
import 'package:onlinebozor/common/widgets/image/order_detail_image_widget.dart';
import 'package:onlinebozor/domain/models/order/order_type.dart';

import '../../../../../../common/core/base_page.dart';
import '../../../../../../common/gen/assets/assets.gen.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class CreateOrderPage extends BasePage<PageCubit, PageState, PageEvent> {
  const CreateOrderPage(this.adId, {super.key});

  final int adId;

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setAdId(adId);
  }

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.onBackAfterRemove:
        context.router.replace(CartRoute());
      case PageEventType.onOpenAfterCreation:
        context.router.replace(UserOrderListRoute(orderType: OrderType.buy));
      case PageEventType.onOpenAuthStart:
        context.router.push(AuthStartRoute());
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    var formatter = NumberFormat('###,000');

    return state.adDetail == null
        ? Scaffold(
            appBar: DefaultAppBar(
              Strings.cartMakeOrder,
              () => context.router.pop(),
            ),
            body: CreateOrderShimmer(),
          )
        : Scaffold(
            appBar: DefaultAppBar(
              Strings.cartMakeOrder,
              () => context.router.pop(),
            ),
            backgroundColor: StaticColors.backgroundColor,
            bottomNavigationBar: _buildBottomBar(context, state, formatter),
            body: SafeArea(
              bottom: true,
              child: ListView(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(height: 16),
                  _buildImageList(state),
                  SizedBox(height: 16),
                  _buildInfoBlock(context, state, formatter),
                  SizedBox(height: 16),
                  _buildPaymentTypes(context, state),
                ],
              ),
            ),
          );
  }

  Widget _buildImageList(PageState state) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        height: 100,
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: state.adDetail?.photos?.length ?? 0,
          padding: EdgeInsets.only(left: 10, right: 16),
          itemBuilder: (context, index) {
            return OrderDetailImageWidget(
              imageId: state.adDetail!.photos?[index].image ?? "",
              onClicked: (imageId) {
                context.router.push(
                  ImageViewerRoute(
                    images: cubit(context).getImages(),
                    initialIndex: index,
                  ),
                );
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 10);
          },
        ),
      ),
    );
  }

  Container _buildInfoBlock(
    BuildContext context,
    PageState state,
    NumberFormat formatter,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Row(
            children: [
              (state.adDetail?.adName ?? "")
                  .w(600)
                  .s(18)
                  .c(Color(0xFF41455E))
                  .copyWith(maxLines: 3, overflow: TextOverflow.ellipsis),
            ],
          ),
          SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "${Strings.orderCreateAddress}:"
                  .w(500)
                  .s(14)
                  .c(Color(0xFF9EABBE)),
              SizedBox(width: 4),
              Expanded(
                child: (state.adDetail?.address?.name ?? "")
                    .w(500)
                    .s(14)
                    .c(Color(0xFF41455E))
                    .copyWith(maxLines: 3, overflow: TextOverflow.ellipsis),
              )
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              "${Strings.orderCreateCategory}:"
                  .w(500)
                  .s(14)
                  .c(Color(0xFF9EABBE)),
              SizedBox(width: 4),
              Expanded(
                child: (state.adDetail?.categoryName ?? "")
                    .w(500)
                    .s(14)
                    .c(Color(0xFF41455E))
                    .copyWith(maxLines: 3, overflow: TextOverflow.ellipsis),
              )
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              "${Strings.orderCreatePrice}:".w(500).s(14).c(Color(0xFF9EABBE)),
              SizedBox(width: 4),
              state.adDetail?.price == 0
                  ? ("${formatter.format(state.adDetail?.toPrice).replaceAll(',', ' ')}-"
                          "${formatter.format(state.adDetail?.fromPrice).replaceAll(',', ' ')} ${state.adDetail?.currency.getName}"
                      .w(600)
                      .s(16)
                      .c(Color(0xFF5C6AC3))
                      .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis))
                  : ("${formatter.format(state.adDetail?.price).replaceAll(',', ' ')} ${state.adDetail?.currency.getName}"
                      .w(600)
                      .s(16)
                      .c(Color(0xFF5C6AC3))
                      .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis)),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              OrderAdFavoriteWidget(
                isFavorite: state.favorite,
                onClicked: () => cubit(context).changeFavorite(),
                size: 40,
              ),
              SizedBox(width: 12),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    cubit(context).removeCart();
                    vibrateAsHapticFeedback();
                  },
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    height: 40,
                    width: 40,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(width: 1, color: Color(0xFFDFE2E9)),
                    ),
                    child: Assets.images.icDelete.svg(),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Spacer(),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(width: 1, color: Color(0xFFDFE2E9)),
                ),
                child: Row(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          bottomLeft: Radius.circular(6),
                        ),
                        onTap: () {
                          cubit(context).decrease();
                          vibrateAsHapticFeedback();
                        },
                        child: SizedBox(
                          width: 44,
                          height: 44,
                          child: Icon(Icons.remove, size: 24),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    state.count.toString().w(600),
                    SizedBox(width: 15),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(6),
                          bottomRight: Radius.circular(6),
                        ),
                        onTap: () {
                          cubit(context).increase();
                          vibrateAsHapticFeedback();
                        },
                        child: SizedBox(
                          width: 44,
                          height: 44,
                          child: Icon(Icons.add, size: 24),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16)
            ],
          ),
          SizedBox(height: 12)
        ],
      ),
    );
  }

  Widget _buildPaymentTypes(BuildContext context, PageState state) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Strings.orderCreatePaymentMethod.w(700).s(16).c(Color(0xFF41455E)),
          SizedBox(height: 8),
          Visibility(
            visible: state.paymentType.isNotEmpty,
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                cubit(context).setPaymentType(1);
                vibrateAsHapticFeedback();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: Color(0xFFDEE1E8)),
                ),
                child: Row(
                  children: [
                    state.paymentId == 1
                        ? Assets.images.icRadioButtonSelected.svg()
                        : Assets.images.icRadioButtonUnSelected.svg(),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Strings.orderCreateCashPayment
                              .w(600)
                              .c(Color(0xFF41455E))
                              .s(14),
                          SizedBox(height: 4),
                          Strings.orderCreateCashDescription
                              .w(400)
                              .s(12)
                              .c(Color(0xFF9EABBE))
                              .copyWith(
                                  maxLines: 2, overflow: TextOverflow.ellipsis)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Container _buildBottomBar(
    BuildContext context,
    PageState state,
    NumberFormat formatter,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        border: Border.all(
          color: Color(0xFF9EABBE),
          width: .25,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12),
          Row(
            children: [
              SizedBox(width: 16),
              "${Strings.orderCreateTotalPrice}:".w(600).s(16),
              SizedBox(width: 8),
              "${formatter.format(state.adDetail!.price * state.count).replaceAll(',', ' ')} ${state.adDetail!.currency.getName}"
                  .w(800)
                  .s(18)
                  .c(Color(0xFF5C6AC3))
                  .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis),
              SizedBox(width: 16),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              SizedBox(width: 16),
              Expanded(
                child: CustomElevatedButton(
                  text: Strings.cartMakeOrder,
                  onPressed: () => cubit(context).orderCreate(),
                ),
              ),
              SizedBox(width: 16)
            ],
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

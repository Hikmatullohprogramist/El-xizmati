import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/colors/color_extension.dart';
import 'package:onlinebozor/presentation/support/extensions/controller_exts.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/core/vibrator/vibrator_extension.dart';
import 'package:onlinebozor/domain/models/order/order_type.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/extensions/mask_formatters.dart';
import 'package:onlinebozor/presentation/support/extensions/resource_exts.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/favorite/order_ad_favorite_widget.dart';
import 'package:onlinebozor/presentation/widgets/favorite/order_ad_remove_widget.dart';
import 'package:onlinebozor/presentation/widgets/form_field/custom_dropdown_form_field.dart';
import 'package:onlinebozor/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:onlinebozor/presentation/widgets/form_field/label_text_field.dart';
import 'package:onlinebozor/presentation/widgets/form_field/validator/default_validator.dart';
import 'package:onlinebozor/presentation/widgets/image/rounded_cached_network_image_widget.dart';
import 'package:onlinebozor/presentation/widgets/order/create_order_shimmer.dart';

import 'cubit/page_cubit.dart';

@RoutePage()
class CreateOrderPage extends BasePage<PageCubit, PageState, PageEvent> {
  CreateOrderPage(this.adId, {super.key});

  final int adId;

  final TextEditingController priceController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
        context.router.replace(UserOrdersRoute(orderType: OrderType.buy));
      case PageEventType.onOpenAuthStart:
        context.router.push(AuthStartRoute());
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    priceController.updateOnRestore(priceMaskFormatter.formatInt(state.price));

    return state.adDetail == null
        ? Scaffold(
            appBar: DefaultAppBar(
              titleText: Strings.cartMakeOrder,
              backgroundColor: context.appBarColor,
              onBackPressed: () => context.router.pop(),
            ),
            body: CreateOrderShimmer(),
          )
        : Scaffold(
            appBar: DefaultAppBar(
              titleText: Strings.cartMakeOrder,
              backgroundColor: context.appBarColor,
              onBackPressed: () => context.router.pop(),
            ),
            backgroundColor: context.backgroundColor,
            bottomNavigationBar: _buildBottomBar(context, state),
            body: SafeArea(
              bottom: true,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(height: 16),
                      _buildImageList(context, state),
                      SizedBox(height: 16),
                      _buildInfoBlock(context, state),
                      SizedBox(height: 16),
                      _buildPaymentTypes(context, state),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget _buildImageList(BuildContext context, PageState state) {
    return Container(
      color: context.primaryContainer,
      padding: EdgeInsets.symmetric(vertical: 16),
      child: SizedBox(
        height: 100,
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: state.adDetail?.photos?.length ?? 0,
          padding: EdgeInsets.only(left: 16, right: 16),
          itemBuilder: (context, index) {
            return InkWell(
                borderRadius: BorderRadius.circular(6),
                child: RoundedCachedNetworkImage(
                  imageId: state.adDetail!.photos?[index].image ?? "",
                  imageWidth: 160,
                ),
                onTap: () {
                  context.router.push(
                    ImageViewerRoute(
                      images: cubit(context).getImages(),
                      initialIndex: index,
                    ),
                  );
                });
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(width: 10);
          },
        ),
      ),
    );
  }

  Widget _buildInfoBlock(BuildContext context, PageState state) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color: context.primaryContainer,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: (state.adDetail?.adName ?? "")
                    .w(600)
                    .s(18)
                    .c(Color(0xFF41455E))
                    .copyWith(maxLines: 3, overflow: TextOverflow.ellipsis),
              ),
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
              cubit(context)
                  .getProductPrice()
                  .w(600)
                  .s(16)
                  .c(Color(0xFF5C6AC3))
                  .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              OrderAdFavoriteWidget(
                size: 40,
                isFavorite: state.favorite,
                onClicked: () => cubit(context).changeFavorite(),
              ),
              SizedBox(width: 12),
              OrderAdRemoveWidget(
                size: 40,
                onClicked: () => cubit(context).removeCart(),
              ),
              Spacer(),
              IgnorePointer(
                ignoring: (state.adDetail?.hasRangePrice() ?? true),
                child: Container(
                  height: 44,
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
                      SizedBox(width: 16),
                      state.count.toString().w(600),
                      SizedBox(width: 16),
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
              ),
              // SizedBox(width: 16)
            ],
          ),
          Visibility(
            visible: state.hasRangePrice,
            child: SizedBox(height: 16),
          ),
          Visibility(
            visible: state.hasRangePrice,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 5,
                  child: Column(
                    children: [
                      LabelTextField(Strings.createAdPriceLabel),
                      SizedBox(height: 6),
                      CustomTextFormField(
                        autofillHints: const [AutofillHints.transactionAmount],
                        inputType: TextInputType.number,
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        minLines: 1,
                        hint: "-",
                        textInputAction: TextInputAction.next,
                        inputFormatters: priceMaskFormatter,
                        controller: priceController,
                        validator: (v) => NotEmptyValidator.validate(v),
                        onChanged: (value) {
                          cubit(context).setEnteredPrice(value);
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Flexible(
                  flex: 4,
                  child: Column(
                    children: [
                      LabelTextField(Strings.createAdCurrencyLabel),
                      SizedBox(height: 6),
                      CustomDropdownFormField(
                        value:
                            state.adDetail?.currency.getLocalizedName() ?? "",
                        hint: "-",
                        validator: (v) => NotEmptyValidator.validate(v),
                        onTap: () {},
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 12)
        ],
      ),
    );
  }

  Widget _buildPaymentTypes(BuildContext context, PageState state) {
    return Container(
      color: context.primaryContainer,
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

  Container _buildBottomBar(BuildContext context, PageState state) {
    return Container(
      decoration: BoxDecoration(
        color: context.primaryContainer,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        border: Border.all(
          color: context.primaryContainerStrokeColor,
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
              cubit(context)
                  .getOrderPrice()
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
                  onPressed: () {
                    vibrateAsHapticFeedback();
                    if (_formKey.currentState!.validate()) {
                      cubit(context).orderCreate();
                    }
                  },
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

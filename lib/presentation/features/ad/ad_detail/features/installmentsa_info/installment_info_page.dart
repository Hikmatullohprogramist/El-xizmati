import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/data/datasource/network/constants/constants.dart';
import 'package:onlinebozor/data/datasource/network/responses/ad/ad_detail/ad_detail_response.dart';
import 'package:onlinebozor/domain/models/ad/ad_detail.dart';
import 'package:onlinebozor/domain/models/currency/currency_code.dart';
import 'package:onlinebozor/presentation/features/ad/ad_detail/features/installmentsa_info/cubit/installment_info_cubit.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/mask_formatters.dart';
import 'package:onlinebozor/presentation/widgets/ad/list_price_text_widget.dart';
import 'package:onlinebozor/presentation/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/divider/custom_divider.dart';
import 'package:onlinebozor/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:onlinebozor/presentation/widgets/image/rounded_cached_network_image_widget.dart';

@RoutePage()
class InstallmentInfoPage extends BasePage<InstallmentInfoCubit,
    InstallmentInfoState,
    InstallmentInfoEvent> {
  InstallmentInfoPage({super.key, required this.detail});

  final AdDetail detail;

  final TextEditingController priceController = TextEditingController();

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(detail);
    Logger().d(detail.adId);
  }

  @override
  void onEventEmitted(BuildContext context, InstallmentInfoEvent event) {
    // switch (event.type) {
    //   case InstallmentInfoEventType.onBackAfterRemove:
    //   // context.router.replace(CartRoute());
    //   case InstallmentInfoEventType.onOpenAfterCreation:
    //     context.router.replace(UserOrdersSmartRoute());
    //   case InstallmentInfoEventType.onOpenAuthStart:
    //     context.router
    //         .push(AuthStartRoute(navigatorKey: NavigateRoute.navigateCreation));
    //   case InstallmentInfoEventType.onFailure:
    //     context.showErrorBottomSheet(
    //         context, Strings.loadingStateError, Strings.createOrderErrorTitle);
    // }
  }

  @override
  Widget onWidgetBuild(BuildContext context, InstallmentInfoState state) {
    // priceController.updateOnRestore(cubit(context).formattedStartPrice());
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Color(0xFFfafafa),
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    BottomSheetTitle(
                      title: Strings.commonInstallment,
                      onCloseClicked: () {
                        context.router.pop();
                      },
                    ),
                    _productItem(context, detail, state),
                    _incAndDecBlock(context, state),
                    CustomDivider(),
                    SizedBox(height: 10),
                    if (state.emptyPlanPaymentState == LoadingState.success)
                      Column(children: [
                        Container(
                          height: 120,
                          margin: EdgeInsets.only(left: 10),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemCount: state.planPayments.length,
                            itemBuilder: (BuildContext context, int index) {
                              final item = state.planPayments[index];
                              //   return _monthsBlock(
                              //       item, state, cubit(context), index);
                            },
                          ),
                        ),

                        ///  boshlangich to'lov
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            children: [
                              Strings.planInstallmentsStartPrice
                                  .w(500)
                                  .s(14)
                                  .c(StaticColors.textColorPrimary),
                              SizedBox(width: 5),
                              Assets.images.icRedStart.svg()
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: CustomTextFormField(
                            keyboardType: TextInputType.number,
                            inputType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            readOnly: false,
                            maxLines: 1,
                            maxLength: 15,
                            hint: Strings.planInstallmentsStartPrice,
                            inputFormatters: quantityMaskFormatter,
                            // errorMessage: Strings.loginWithPhoneNumberError,
                            controller: priceController,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                cubit(context).checkStartPrice("0");
                              } else {
                                cubit(context).checkStartPrice(value);
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                          child: Row(
                            children: [
                              Assets.images.icComplain.svg(
                                  color: state.enableStartPrice
                                      ? Color(0xFFa855f7)
                                      : Colors.red),
                              SizedBox(width: 2),
                              Strings.planInstallmentsMinimumPrice
                                  .w(400)
                                  .s(12)
                                  .c(state.enableStartPrice
                                  ? Color(0xFFa855f7)
                                  : Colors.red),
                              SizedBox(width: 2),
                              ListPriceTextWidget(
                                price: (state.constCurrentSelectionMonth
                                    ?.contsStartingPrice ??
                                    0) *
                                    state.productCount as int,
                                color: state.enableStartPrice
                                    ? Color(0xFFa855f7)
                                    : Colors.red,
                                currency: CurrencyCode.uzs,
                                fromPrice: 0,
                                toPrice: 0,
                              ),
                              SizedBox(width: 2),
                              Strings.currencyUzs.w(400).s(12).c(
                                  state.enableStartPrice
                                      ? Color(0xFFa855f7)
                                      : Colors.red),
                            ],
                          ),
                        ),

                        /// Birinchi tolov sanasi
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15, top: 10, bottom: 5),
                          child: Row(
                            children: [
                              Strings.planInstallmentsStartDate
                                  .w(500)
                                  .s(14)
                                  .c(StaticColors.textColorPrimary),
                              SizedBox(width: 5),
                              Assets.images.icRedStart.svg()
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // context.showInstallmentCalendar(
                            //     context, state, cubit(context));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CustomTextFormField(
                              // autofillHints: const [AutofillHints.password],
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.next,
                              readOnly: false,
                              maxLines: 1,
                              maxLength: 15,
                              controller:
                              TextEditingController(text: state.startDate),
                              enabled: false,
                              // errorMessage: Strings.loginWithPhoneNumberError,
                              onChanged: (value) {
                                //  cubit(context).setPassword(value);
                              },
                            ),
                          ),
                        ),

                        /// oylik to'lov
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Row(
                            children: [
                              "${Strings.planInstallmentsMonthlyPrice}:"
                                  .w(500)
                                  .s(14)
                                  .c(StaticColors.textColorPrimary),
                              SizedBox(width: 5),
                              ListPriceTextWidget(
                                price: state.planPayments[state.selectionItem]
                                    .monthlyPrice *
                                    state.productCount as int,
                                color: StaticColors.majorelleBlue,
                                currency: CurrencyCode.uzs,
                                fromPrice: 0,
                                toPrice: 0,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              "${Strings.commonAllPrice}:"
                                  .w(500)
                                  .s(14)
                                  .c(StaticColors.textColorPrimary),
                              SizedBox(width: 5),
                              ListPriceTextWidget(
                                // price: state.planPayments[state.selectionItem].totalPrice * state.productCount,
                                price: state.overallSumma as int,
                                color: StaticColors.textColorPrimary,
                                currency: CurrencyCode.uzs,
                                fromPrice: 0,
                                toPrice: 0,
                              ),
                            ],
                          ),
                        ),

                        ///  To'lov jadvali
                        InkWell(
                          onTap: () {
                            _showInstallmentTablePage(context, state);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                              children: [
                                Assets.images.icCalendar
                                    .svg(color: StaticColors.majorelleBlue),
                                SizedBox(width: 5),
                                Strings.planInstallmentsTableTitle
                                    .w(500)
                                    .s(14)
                                    .c(StaticColors.majorelleBlue),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ]),
                    if (state.emptyPlanPaymentState == LoadingState.loading)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Strings.commonCalculateLoading
                                  .w(500)
                                  .s(14)
                                  .c(StaticColors.textColorPrimary),
                              SizedBox(width: 10),
                              SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: StaticColors.majorelleBlue,
                                    strokeWidth: 3,
                                  ))
                            ]),
                      ),
                    if (state.emptyPlanPaymentState == LoadingState.error)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 10),
                                child: Strings.smInstallmentErrorTitle
                                    .w(500)
                                    .s(14)
                                    .c(StaticColors.textColorPrimary)
                                    .copyWith(textAlign: TextAlign.center),
                              ),
                              SizedBox(height: 25),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 120),
                                child: CustomElevatedButton(
                                    text: Strings.commonDownloadAgain,
                                    onPressed: () {
                                      cubit(context).setInitialParams(detail);
                                    }),
                              )
                            ]),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: CustomElevatedButton(
                        buttonHeight: 45,
                        text: Strings.cartMakeOrder,
                        onPressed: () {
                          cubit(context).orderCreate();
                        },
                        isEnabled: state.enableStartPrice,
                        isLoading: state.orderCreationState,
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _productItem(BuildContext context,
      AdDetail item,
      InstallmentInfoState state,) {
    print("photo: ${item.photos?.firstOrNull}");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          SizedBox(width: 5),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: RoundedCachedNetworkImage(
              imageId: item.photos?.firstOrNull ?? "",
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child:
                      (item.adName).toString().w(600).s(14).copyWith(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5),
                ListPriceTextWidget(
                  color: StaticColors.majorelleBlue,
                  price: item.price ?? 0,
                  toPrice: 5,
                  fromPrice: 5,
                  currency: CurrencyCode.uzs,
                ),
                SizedBox(height: 5),
                InkWell(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    // context.router.push(AdListRoute(
                    //   sellerTin: state.productDetail?.seller?.tin,
                    // ));
                  },
                  child: "${item.seller?.fullName}".w(500).s(13).copyWith(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationThickness: 0.8)),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _incAndDecBlock(BuildContext context, InstallmentInfoState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Row(
        children: [
          Row(
            children: [
              Material(
                child: InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () {
                    cubit(context).decreaseProductCount();
                    HapticFeedback.lightImpact();
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Color(0xFFDFE2E9), // Set the border color
                        width: 1.0, // Set the border width
                      ),
                    ),
                    child: Assets.images.icCartMinus.svg(),
                  ),
                ),
              ),
              Container(
                  width: 70,
                  height: 35,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Color(0xFFECEFF7),
                      borderRadius: BorderRadius.circular(4)),
                  child: Center(
                    child: "${state.productCount}"
                        .w(600)
                        .s(14)
                        .c(Color(0xFF41455E))
                        .copyWith(overflow: TextOverflow.ellipsis, maxLines: 2),
                  )),
              Material(
                child: InkWell(
                  borderRadius: BorderRadius.circular(6),
                  onTap: () {
                    cubit(context).increaseProductCount();
                    HapticFeedback.lightImpact();
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Color(0xFFDFE2E9), // Set the border color
                        width: 1.0, // Set the border width
                      ),
                    ),
                    child: Assets.images.icCartPlus.svg(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 20),
          Expanded(
              child:
              "${Strings.adDetailSaleCountStart} ${state.productCount} ${Strings.adDetailSaleCountEnd}"
                  .w(500)
                  .s(14)
                  .c(StaticColors.majorelleBlue)
                  .copyWith(maxLines: 2)),
        ],
      ),
    );
  }

  Widget _monthsBlock(BuildContext context,
      AdDetail item,
      InstallmentInfoState state,
      int index,) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          cubit(context).selectedItemMonth(index);
        },
        child: Container(
          height: 120,
          width: 110,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  width: 1,
                  color: item.isInCart
                      ? StaticColors.majorelleBlue
                      : Color(0xFFe5e7eb))),
          child: Column(
            children: [
              SizedBox(height: 10),
              "${item.installmentInfo!.monthCount} ${Strings.commonMonth}"
                  .w(600)
                  .s(20)
                  .c(StaticColors.textColorPrimary),
              SizedBox(height: 15),
              ListPriceTextWidget(
                price: (item.installmentInfo!.monthlyPrice as int) *
                    state.productCount ?? 0,
                color: StaticColors.majorelleBlue,
                currency: CurrencyCode.uzs,
                fromPrice: item.fromPrice,
                toPrice: item.toPrice,
              ),
              SizedBox(height: 8),
              "${Strings.currencyUzs} / ${Strings.commonMonth}"
                  .w(600)
                  .s(14)
                  .c(StaticColors.textColorPrimary),
            ],
          ),
        ),
      ),
    );
  }

  void _showInstallmentTablePage(BuildContext context,
      InstallmentInfoState state) async {
      // final monthlyId = state.currentSelectionMonth?.monthId ?? 3;
      // final item = state.planPayments[state.selectionItem];
      // final monthlyPrice = item.monthlyPrice * state.productCount;
      // InstallmentTablePage installmentTable = InstallmentTablePage(
      //   month: monthlyId,
      //   allPrice: state.overallSumma,
      //   monthlyPrice: monthlyPrice,
      //   dateTime: state.startDay!,
      // );
      // var result = await showModalBottomSheet(
      //   isDismissible: false,
      //   context: context,
      //   isScrollControlled: true,
      //   useSafeArea: true,
      //   backgroundColor: Colors.transparent,
      //   builder: (context) {
      //     return installmentTable;
      //   },
      // );
    }
  }
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/data/datasource/network/constants/constants.dart';
import 'package:onlinebozor/data/datasource/network/responses/transaction/payment_transaction_response.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/action_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_text_button.dart';
import 'package:onlinebozor/presentation/widgets/divider/custom_divider.dart';
import 'package:onlinebozor/presentation/widgets/loading/default_error_widget.dart';
import 'package:onlinebozor/presentation/widgets/transaction/transaction_empty_widget.dart';
import 'package:onlinebozor/presentation/widgets/transaction/transaction_widget.dart';
import 'package:onlinebozor/presentation/widgets/transaction/transaction_widget_shimmer.dart';

import 'payment_transactions_cubit.dart';

@RoutePage()
class PaymentTransactionsPage extends BasePage<PaymentTransactionsCubit,
    PaymentTransactionsState, PaymentTransactionsEvent> {
  const PaymentTransactionsPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PaymentTransactionsState state) {
    return Scaffold(
      appBar: ActionAppBar(
        titleText: Strings.paymentTitle,
        titleTextColor: context.textPrimary,
        backgroundColor: context.appBarColor,
        onBackPressed: () => context.router.pop(),
        actions: [
          CustomTextButton(
            text: Strings.commonFilter,
            onPressed: () =>
                context.router.push(PaymentTransactionFilterRoute()),
          )
        ],
      ),
      backgroundColor: context.backgroundGreyColor,
      body: _getPaymentListWidget(context, state),
    );
  }

  Widget _getPaymentListWidget(
    BuildContext context,
    PaymentTransactionsState state,
  ) {
    return PagedListView<int, dynamic>(
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      pagingController: state.controller!,
      builderDelegate: PagedChildBuilderDelegate<dynamic>(
        firstPageErrorIndicatorBuilder: (_) {
          return DefaultErrorWidget(
            isFullScreen: true,
            onRetryClicked: () => cubit(context).states.controller?.refresh(),
          );
        },
        firstPageProgressIndicatorBuilder: (_) {
          return SingleChildScrollView(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 15,
              itemBuilder: (BuildContext context, int index) {
                return TransactionShimmer();
              },
            ),
          );
        },
        noItemsFoundIndicatorBuilder: (_) {
          return TransactionEmptyWidget(listener: () {});
        },
        newPageProgressIndicatorBuilder: (_) {
          return SizedBox(
            height: 160,
            child: Center(
              child: CircularProgressIndicator(color: Colors.blue),
            ),
          );
        },
        newPageErrorIndicatorBuilder: (_) {
          return DefaultErrorWidget(
            isFullScreen: false,
            onRetryClicked: () => cubit(context).states.controller?.refresh(),
          );
        },
        transitionDuration: Duration(milliseconds: 100),
        itemBuilder: (context, item, index) {
          return InkWell(
              onTap: () {
                log(item.toString());
                showTransactionDetailBottomSheet(context, item);
              },
              child: TransactionWidget(transaction: item));
        },
      ),
    );
  }

  Future<void> showTransactionDetailBottomSheet(
    BuildContext context,
    PaymentTransaction transaction,
  ) async {
    await showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 300,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            // Adjust the radius as needed
            topRight: Radius.circular(10.0), // Adjust the radius as needed
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (transaction.pay_method == "REALPAY")
                        SvgPicture.asset(
                          'assets/images/real_pay.svg',
                        )
                      else
                        CachedNetworkImage(
                          imageUrl: Constants.baseUrlForImage,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.white, BlendMode.colorBurn)),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6)),
                            child: Center(child: Icon(Icons.error)),
                          ),
                        )
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        NumberFormat('#,###')
                            .format(double.parse(transaction.amount.toString()))
                            .w(700)
                            .s(16)
                            .c(Color(0xFF41455E)),
                        SizedBox(
                          width: 7,
                        ),
                        "UZS".w(700).s(16).c(Color(0xFF41455E)),
                      ],
                    ),
                    SizedBox(height: 6),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: transaction.pay_status
                          .w(500)
                          .s(14)
                          .c(Color(0xFF32B88B)),
                    )
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(
                        'assets/images/ic_close.svg',
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomDivider(height: 1),
            ),
            SizedBox(height: 7),
            "Transaction data".w(500).s(12).c(Color(0xFF41455E)),
            SizedBox(height: 5),
            transaction.pay_date.w(500).s(16).c(Color(0xFF41455E)),
            SizedBox(height: 10),

            ///
            "Payment type".w(500).s(12).c(Color(0xFF41455E)),
            SizedBox(height: 2),
            transaction.pay_type.w(500).s(15).c(Color(0xFF41455E)),
            SizedBox(
              height: 12,
            ),

            ///
            "Node".w(500).s(12).c(Color(0xFF41455E)),
            (transaction.note ?? "***").w(500).s(16).c(Color(0xFF41455E)),
          ],
        ),
      ),
    );
  }
}

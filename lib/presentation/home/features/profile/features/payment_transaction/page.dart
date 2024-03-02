import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/app_bar/action_app_bar.dart';
import 'package:onlinebozor/common/widgets/button/custom_text_button.dart';
import 'package:onlinebozor/common/widgets/transaction/transaction_empty_widget.dart';
import 'package:onlinebozor/common/widgets/transaction/transaction_widget.dart';

import '../../../../../../common/gen/localization/strings.dart';
import '../../../../../../common/router/app_router.dart';
import '../../../../../../common/widgets/button/common_button.dart';
import '../../../../../../common/widgets/transaction/transaction_widget_shimmer.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class PaymentTransactionPage extends BasePage<PageCubit, PageState, PageEvent> {
  const PaymentTransactionPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: ActionAppBar(
        titleText: Strings.paymentTitle,
        onBackPressed: () => context.router.pop(),
        actions: [
          CustomTextButton(
            text: Strings.commonFilter,
            onPressed: () =>
                context.router.push(PaymentTransactionFilterRoute()),
          )
        ],
      ),
      backgroundColor: Color(0xFFF2F4FB),
      body: _getPaymentListWidget(context, state),
    );
  }

  Widget _getPaymentListWidget(
    BuildContext context,
    PageState state,
  ) {
    return PagedListView<int, dynamic>(
      shrinkWrap: true,
      addAutomaticKeepAlives: true,
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      pagingController: state.controller!,
      builderDelegate: PagedChildBuilderDelegate<dynamic>(
        firstPageErrorIndicatorBuilder: (_) {
          return SizedBox(
            height: 100,
            child: Center(
              child: Column(
                children: [
                  Strings.loadingStateError
                      .w(400)
                      .s(14)
                      .c(context.colors.textPrimary),
                  SizedBox(height: 12),
                  CommonButton(
                      onPressed: () {},
                      type: ButtonType.elevated,
                      child: Strings.loadingStateRetry.w(400).s(15))
                ],
              ),
            ),
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
          return SizedBox(
            height: 160,
            child: Center(
              child: CircularProgressIndicator(color: Colors.blue),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 100),
        itemBuilder: (context, item, index) {
          return TransactionWidget(transaction: item);
        },
      ),
    );
  }
}

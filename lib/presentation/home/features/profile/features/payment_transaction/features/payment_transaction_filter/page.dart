import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/common/common_button.dart';
import 'package:onlinebozor/common/widgets/dashboard/app_diverder.dart';
import 'package:onlinebozor/presentation/home/features/profile/features/payment_transaction/features/payment_transaction_filter/cubit/page_cubit.dart';

import '../../../../../../../../common/core/base_page.dart';
import '../../../../../../../../common/widgets/app_bar/default_app_bar.dart';

@RoutePage()
class PaymentTransactionFilterPage
    extends BasePage<PageCubit, PageState, PageEvent> {
  const PaymentTransactionFilterPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: DefaultAppBar(
        Strings.commonFilter,
        () => context.router.pop(),
      ),
      body: Column(children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
          child: Row(
            children: [
              Flexible(
                  flex: 1,
                  child: InkWell(
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFFAF9FF),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: Color(0xFFFAF9FF),
                              )),
                          padding: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Strings.paymentFilterFromDate
                                  .w(600)
                                  .s(14)
                                  .c(Color(0xFF9EABBE)),
                              Assets.images.icCalendar
                                  .svg(height: 24, width: 24)
                            ],
                          )))),
              SizedBox(width: 16),
              Flexible(
                flex: 1,
                child: InkWell(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFFAF9FF),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 1,
                              color: Color(0xFFFAF9FF),
                            )),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Strings.paymentFilterToDate
                                .w(600)
                                .s(14)
                                .c(Color(0xFF9EABBE)),
                            Assets.images.icCalendar.svg(height: 24, width: 24)
                          ],
                        ))),
              ),
            ],
          ),
        ),
        InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Strings.paymentFilterPaymentType.w(400).c(Colors.black).s(12),
                  Spacer(),
                  Strings.paymentFilterAll.w(400).s(12).c(Color(0xFF9EABBE)),
                  SizedBox(width: 16),
                  Assets.images.icArrowRight.svg(width: 24, height: 24)
                ],
              ),
            )),
        AppDivider(height: 1),
        InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Strings.paymentFilterPaymentMethod
                      .w(400)
                      .c(Colors.black)
                      .s(12),
                  Spacer(),
                  Strings.paymentFilterAll.w(400).s(12).c(Color(0xFF9EABBE)),
                  SizedBox(width: 16),
                  Assets.images.icArrowRight.svg(width: 24, height: 24),
                ],
              ),
            )),
        AppDivider(height: 1),
        InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Strings.paymentFilterType.w(400).c(Colors.black).s(12),
                  Spacer(),
                  Strings.paymentFilterAll.w(400).s(12).c(Color(0xFF9EABBE)),
                  SizedBox(width: 16),
                  Assets.images.icArrowRight.svg(width: 24, height: 24)
                ],
              ),
            )),
        AppDivider(height: 1),
        InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Strings.paymentFilterStatus.w(400).c(Colors.black).s(12),
                  Spacer(),
                  Strings.paymentFilterAll.w(400).s(12).c(Color(0xFF9EABBE)),
                  SizedBox(width: 16),
                  Assets.images.icArrowRight.svg(width: 24, height: 24)
                ],
              ),
            )),
        Spacer(),
        Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 24, bottom: 16),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: InkWell(
                      child: SizedBox(
                    child: CommonButton(
                      onPressed: () {},
                      child: Strings.commonFilterReset.s(14).w(600),
                    ),
                  ))),
              SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: InkWell(
                    child: SizedBox(
                  child: CommonButton(
                    onPressed: () {},
                    child: Strings.commonApply.s(14).w(600),
                  ),
                )),
              ),
            ],
          ),
        ),
        SizedBox(height: 24)
      ]),
    );
  }
}

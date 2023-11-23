import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../common/widgets/card_empty_widget.dart';
import 'cubit/payment_transaction_cubit.dart';

@RoutePage()
class PaymentTransactionPage extends BasePage<PaymentTransactionCubit,
    PaymentTransactionBuildable, PaymentTransactionListenable> {
  const PaymentTransactionPage({super.key});

  @override
  Widget builder(BuildContext context, PaymentTransactionBuildable state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
          title: 'Платежи'.w(500).s(14).c(context.colors.textPrimary),
          centerTitle: true,
          elevation: 0.5,
          // actions: [
          //   CommonButton(
          //       type: ButtonType.text,
          //       onPressed: () =>
          //           context.router.push(PaymentTransactionFilterRoute()),
          //       child: "Фильтр".w(500).s(12).c(Color(0xFF5C6AC3)))
          // ],
          leading: IconButton(
            icon: Assets.images.icArrowLeft.svg(),
            onPressed: () => context.router.pop(),
          ),
        ),
        body: Column(children: [
          // if (state.isEmpty)
          CardEmptyWidget(
            callBack: () {
              // context.router.push(AddCardRoute());
            },
          )
          // else
          //   CardWidget(
          //       onClick: () {},
          //       image: "8a818006f6ddda2c7af7dbf4",
          //       onClickSetting: () {
          //         _edit();
          //       })
        ])

        // ListView.separated(
        //   physics: BouncingScrollPhysics(),
        //   itemBuilder: (BuildContext context, int index) {
        //     return TransactionWidget();
        //   },
        //   separatorBuilder: (BuildContext context, int index) {
        //     return AppDivider();
        //   },
        //   itemCount: 10,
        // ),
        );
  }
}

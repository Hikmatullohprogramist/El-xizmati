import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/payment_transaction/features/payment_transaction_filter/cubit/payment_transaction_filter_cubit.dart';

import '../../../../../../../common/gen/assets/assets.gen.dart';

@RoutePage()
class PaymentTransactionFilterPage extends BasePage<
    PaymentTransactionFilterCubit,
    PaymentTransactionFilterBuildable,
    PaymentTransactionFilterListenable> {
  const PaymentTransactionFilterPage({super.key});

  @override
  Widget builder(
      BuildContext context, PaymentTransactionFilterBuildable state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: 'Фильтр'.w(500).s(14).c(context.colors.textPrimary),
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: Center(child: Text("Payment transaction filter")),
    );
  }
}

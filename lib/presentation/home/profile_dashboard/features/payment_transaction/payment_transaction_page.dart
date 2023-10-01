import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';

import 'cubit/payment_transaction_cubit.dart';

@RoutePage()
class PaymentTransactionPage extends BasePage<PaymentTransactionCubit,
    PaymentTransactionBuildable, PaymentTransactionListenable> {
  const PaymentTransactionPage({super.key});

  @override
  Widget builder(BuildContext context, PaymentTransactionBuildable state) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("Payment transactions")),
    );
  }
}

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/ad/create_ad/features/create_exchange_ad/cubit/create_exchange_ad_cubit.dart';

import '../../../../../common/core/base_page.dart';

@RoutePage()
class CreateExchangeAdPage extends BasePage<CreateExchangeAdCubit,
    CreateExchangeAdBuildable, CreateExchangeAdListenable> {
  const CreateExchangeAdPage({super.key});

  @override
  Widget builder(BuildContext context, CreateExchangeAdBuildable state) {
    return Scaffold(
      body: Center(
        child: Text("Create exchange ad page"),
      ),
    );
  }
}

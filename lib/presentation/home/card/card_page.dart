import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';

import 'cubit/card_cubit.dart';

@RoutePage()
class CardPage extends BasePage<CardCubit, CardBuildable, CardListenable> {
  const CardPage({super.key});

  @override
  Widget builder(BuildContext context, CardBuildable state) {
    return Center(
      child: Text("Auth Start"),
    );
  }
}

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/core/base_page.dart';

import 'cubit/my_cards_cubit.dart';

@RoutePage()
class MyCardsPage
    extends BasePage<MyCardsCubit, MyCardsBuildable, MyCardsListenable> {
  const MyCardsPage({super.key});

  @override
  Widget builder(BuildContext context, MyCardsBuildable state) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text("My card"),
      ),
    );
  }
}

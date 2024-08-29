import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/presentation/features/home/features/sp_main/main_cubit.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/widgets/app_bar/action_app_bar.dart';
import 'package:El_xizmati/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../router/app_router.dart';

@RoutePage()
class MainPage extends BasePage<MainCubit, MainState, MainEvent>{
  const MainPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, MainState state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.appBarColor,
      ),
      body: Column(
        children: [
          InkWell(
            onTap: (){
              context.router.push(AdCreateRoute());
            },
            child: Container(
              padding: EdgeInsets.all(60),
              decoration: BoxDecoration(
                color: context.colors.primary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12)
              ),
              child: Text("E'lon yaratish").w(400).s(16),
            ),
          )
        ],
      ),
    );
  }

}
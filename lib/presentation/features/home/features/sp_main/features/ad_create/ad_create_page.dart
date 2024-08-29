import 'package:El_xizmati/presentation/features/home/features/sp_main/features/ad_create/ad_create_cubit.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

@RoutePage()
class AdCreatePage
    extends BasePage<AdCreateCubit, AdCreateState, AdCreateEvent> {
  const AdCreatePage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, AdCreateState state) {
    return Scaffold(
      appBar: DefaultAppBar(
          titleText: "E'lon yaratish",
          titleTextColor: context.colors.primary,
          backgroundColor: context.backgroundWhiteColor,
          onBackPressed: () {}),
    );
  }
}

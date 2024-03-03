import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/button/custom_outlined_button.dart';

import '../../../../common/gen/assets/assets.gen.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class SetLanguagePage extends BasePage<PageCubit, PageState, PageEvent> {
  const SetLanguagePage({super.key});

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.navigationAuthStart:
        context.router.replace(HomeRoute());
        break;
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colors.colorBackgroundPrimary,
        elevation: 0,
      ),
      backgroundColor: context.colors.colorBackgroundPrimary,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Online").w(700).s(32).c(Color(0xFF5C6AC4)),
                  Text("Bozor").w(700).s(32).c(Color(0xFFBAC2D6)),
                ],
              ),
              Spacer(),
              Text(Strings.languageWelcome).w(500).s(24).c(Color(0xFF41455F)),
              Text(Strings.languageSetTitle).w(400).s(12).c(Color(0xFF9EABBE)),
              Spacer(),
              CustomOutlinedButton(
                text: Strings.languageRus,
                onPressed: () {
                  EasyLocalization.of(context)?.setLocale(Locale('ru', 'RU'));
                  cubit(context).setLanguage(Language.ru);
                },
                strokeColor: Color(0xFFE5E9F3),
                rightIcon: Assets.images.pngImages.flagRu.image(),
              ),
              SizedBox(height: 12),
              CustomOutlinedButton(
                text: Strings.languageUzLat,
                onPressed: () {
                  EasyLocalization.of(context)?.setLocale(Locale('uz', 'UZ'));
                  cubit(context).setLanguage(Language.uz);
                },
                strokeColor: Color(0xFFE5E9F3),
                rightIcon: Assets.images.pngImages.flagUz.image(),
              ),
              SizedBox(height: 12),
              CustomOutlinedButton(
                onPressed: () {
                  EasyLocalization.of(context)?.setLocale(Locale('uz', 'UZK'));
                  cubit(context).setLanguage(Language.kr);
                },
                strokeColor: Color(0xFFE5E9F3),
                rightIcon: Assets.images.pngImages.flagUz.image(),
                text: Strings.languageUzCyr,
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:flutter/services.dart';
import 'package:onlinebozor/domain/models/language/language.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_outlined_button.dart';

import 'set_language_cubit.dart';

@RoutePage()
class SetLanguagePage extends BasePage<SetLanguageCubit, SetLanguageState, SetLanguageEvent> {
  const SetLanguagePage({super.key});

  @override
  void onEventEmitted(BuildContext context, SetLanguageEvent event) {
    switch (event.type) {
      case SetLanguageEventType.navigationAuthStart:
        context.router.replace(HomeRoute());
        break;
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, SetLanguageState state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colors.backgroundColor,
        elevation: 0,
      ),
      backgroundColor: context.colors.backgroundColor,
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
              Text(Strings.languageSetTitle).w(400).s(12).c(context.textSecondary),
              Spacer(),
              CustomOutlinedButton(
                text: Strings.languageRus,
                onPressed: () {
                  HapticFeedback.lightImpact();
                  EasyLocalization.of(context)?.setLocale(Locale('ru', 'RU'));
                  cubit(context).setLanguage(Language.russian);
                },
                strokeColor: Color(0xFFE5E9F3),
                rightIcon: Assets.images.pngImages.flagRu.image(),
              ),
              SizedBox(height: 12),
              CustomOutlinedButton(
                text: Strings.languageUzLat,
                onPressed: () {
                  HapticFeedback.lightImpact();
                  EasyLocalization.of(context)?.setLocale(Locale('uz', 'UZ'));
                  cubit(context).setLanguage(Language.uzbekLatin);
                },
                strokeColor: Color(0xFFE5E9F3),
                rightIcon: Assets.images.pngImages.flagUz.image(),
              ),
              SizedBox(height: 12),
              CustomOutlinedButton(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  EasyLocalization.of(context)?.setLocale(Locale('uz', 'UZK'));
                  cubit(context).setLanguage(Language.uzbekCyrill);
                },
                strokeColor: Color(0xFFE5E9F3),
                rightIcon: Assets.images.pngImages.flagUz.image(),
                text: Strings.languageUzCyr,
              ),
              SizedBox(height: 16),
              CustomElevatedButton(
                text: Strings.commonContinue,
                onPressed: () {
                  context.router.replace(HomeRoute());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

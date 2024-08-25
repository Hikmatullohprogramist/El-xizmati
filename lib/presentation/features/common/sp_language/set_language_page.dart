import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/domain/models/language/language.dart';
import 'package:El_xizmati/presentation/router/app_router.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/widgets/button/custom_elevated_button.dart';

import 'set_language_cubit.dart';

// just for push

@RoutePage()
class SetLanguagePage
    extends BasePage<SetLanguageCubit, SetLanguageState, SetLanguageEvent> {
  const SetLanguagePage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, SetLanguageState state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.backgroundWhiteColor,
        elevation: 0,
      ),
      backgroundColor: context.backgroundWhiteColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 35,right: 35, bottom :80, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Assets.images.pngImages.appLogo.image(width: 64, height: 64),
              Text("el xizmati").w(700).s(32).c(Color(0xFF703EDB)),
              Text("ishchilar jamiyati").w(300).s(18).c(Color(0xFF2A174E)),
              SizedBox(height: 50),
              Text(
                "Interfeys\ntilini tanlang",
                textAlign: TextAlign.center,
              ).w(800).s(32).c(Color(0xFF2A174E)),
              Spacer(),
              CustomElevatedButton(
                text: Strings.languageUzLat,
                onPressed: () {
                  HapticFeedback.lightImpact();
                  cubit(context).setLanguage(Language.uzbekCyrill);
                  EasyLocalization.of(context)?.setLocale(Locale('uz', 'UZ'));
                  context.router.push(SetIntroRoute());
                },
              ),
              SizedBox(height: 12),
              CustomElevatedButton(
                text: Strings.languageRus,
                onPressed: () {
                  HapticFeedback.lightImpact();
                  cubit(context).setLanguage(Language.uzbekCyrill);
                  EasyLocalization.of(context)?.setLocale(Locale('ru', 'RU'));
                  context.router.push(SetIntroRoute());
                },
              ),
              SizedBox(height: 12),
              CustomElevatedButton(
                text: Strings.languageUzCyr,
                onPressed: () {
                  HapticFeedback.lightImpact();
                  cubit(context).setLanguage(Language.uzbekCyrill);
                  EasyLocalization.of(context)?.setLocale(Locale('uz', 'UZK'));
                  context.router.push(SetIntroRoute());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

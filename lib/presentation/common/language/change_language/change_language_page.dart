import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/button/custom_outlined_button.dart';
import 'package:onlinebozor/presentation/common/language/change_language/cubit/page_cubit.dart';

import '../../../../../common/core/base_page.dart';
import '../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../common/gen/localization/strings.dart';

@RoutePage()
class ChangeLanguagePage extends BasePage<PageCubit, PageState, PageEvent> {
  const ChangeLanguagePage({super.key});

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.backTo:
        context.router.pop();
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Strings.profileChangeLanguage
            .w(500)
            .s(14)
            .c(context.colors.textPrimary),
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () => context.router.push(ProfileRoute()),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomOutlinedButton(
              text: Strings.languageRus,
              onPressed: () {
                EasyLocalization.of(context)?.setLocale(Locale('ru', 'RU'));
                cubit(context).selectLanguage(Language.russian);
              },
              strokeColor: (state.language == Language.russian
                  ? context.colors.primary
                  : Color(0xFFE5E9F3)),
              rightIcon: Assets.images.pngImages.flagRu.image(),
            ),
            SizedBox(height: 6),
            CustomOutlinedButton(
              text: Strings.languageUzLat,
              onPressed: () {
                EasyLocalization.of(context)?.setLocale(Locale('uz', 'UZ'));
                cubit(context).selectLanguage(Language.uzbekLatin);
              },
              strokeColor: (state.language == Language.uzbekLatin
                  ? context.colors.primary
                  : Color(0xFFE5E9F3)),
              rightIcon: Assets.images.pngImages.flagUz.image(),
            ),
            SizedBox(height: 6),
            CustomOutlinedButton(
              text: Strings.languageUzCyr,
              onPressed: () {
                EasyLocalization.of(context)?.setLocale(Locale('uz', 'UZK'));
                cubit(context).selectLanguage(Language.uzbekCyrill);
              },
              strokeColor: (state.language == Language.uzbekCyrill
                  ? context.colors.primary
                  : Color(0xFFE5E9F3)),
              rightIcon: Assets.images.pngImages.flagUz.image(),
            ),
          ],
        ),
      ),
    );
  }
}

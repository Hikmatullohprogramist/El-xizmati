import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/language/language.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/extensions/resource_exts.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_outlined_button.dart';

import 'cubit/change_language_cubit.dart';

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
        backgroundColor: context.backgroundColor,
        title: Strings.profileChangeLanguage
            .w(500)
            .s(14)
            .c(context.textPrimary),
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () => context.router.push(ProfileRoute()),
        ),
      ),
      backgroundColor: context.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomOutlinedButton(
              text: Strings.languageUzLat,
              onPressed: () {
                const language = Language.uzbekLatin;
                EasyLocalization.of(context)?.setLocale(language.getLocale());
                cubit(context).selectLanguage(language);
              },
              strokeColor: (state.language == Language.uzbekLatin
                  ? context.colors.primary
                  : Color(0xFFE5E9F3)),
              rightIcon: Assets.images.pngImages.flagUz.image(),
            ),
            SizedBox(height: 6),
            CustomOutlinedButton(
              text: Strings.languageRus,
              onPressed: () {
                const language = Language.russian;
                EasyLocalization.of(context)?.setLocale(language.getLocale());
                cubit(context).selectLanguage(language);
              },
              strokeColor: (state.language == Language.russian
                  ? context.colors.primary
                  : Color(0xFFE5E9F3)),
              rightIcon: Assets.images.pngImages.flagRu.image(),
            ),
            SizedBox(height: 6),
            CustomOutlinedButton(
              text: Strings.languageUzCyr,
              onPressed: () {
                const language = Language.uzbekCyrill;
                EasyLocalization.of(context)?.setLocale(language.getLocale());
                cubit(context).selectLanguage(language);
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

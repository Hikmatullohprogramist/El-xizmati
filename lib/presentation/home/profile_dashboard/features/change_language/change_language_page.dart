import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/change_language/cubit/change_language_cubit.dart';

import '../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../common/gen/localization/strings.dart';
import '../../../../../common/widgets/common_button.dart';

@RoutePage()
class ChangeLanguagePage extends BasePage<ChangeLanguageCubit,
    ChangeLanguageBuildable,
    ChangeLanguageListenable> {
  const ChangeLanguagePage({super.key});

  @override
  void listener(BuildContext context, ChangeLanguageListenable state) {
    switch(state.effect){
      case ChangeLanguageEffect.backTo:context.router.pop();
    }
  }

  @override
  Widget builder(BuildContext context, ChangeLanguageBuildable state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Strings.profileDashboardChangeLanguage
            .w(500)
            .s(14)
            .c(context.colors.textPrimary),
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () => context.router.push(ProfileDashboardRoute()),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonButton(
                color: state.language == Language.ru
                    ? context.colors.primary
                    : Color(0xFFE5E9F3),
                onPressed: () {
                  EasyLocalization.of(context)?.setLocale(Locale('ru', 'RU'));
                  context.read<ChangeLanguageCubit>().selectLanguage(
                      Language.ru);
                },
                type: ButtonType.outlined,
                child: SizedBox(
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Strings.languageRus.w(400).s(14).c(Color(0xFF41455F)),
                      Assets.images.pngImages.flagRu.image()
                    ],
                  ),
                )),
            SizedBox(
              height: 6,
            ),
            CommonButton(
                onPressed: () {
                  EasyLocalization.of(context)?.setLocale(Locale('uz', 'UZ'));
                  context.read<ChangeLanguageCubit>().selectLanguage(
                      Language.uz);
                },
                color: state.language == Language.uz
                    ? context.colors.primary
                    : Color(0xFFE5E9F3),
                type: ButtonType.outlined,
                child: SizedBox(
                  height: 48,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Strings.languageUzb.w(400).s(14).c(Color(0xFF41455F)),
                      Assets.images.pngImages.flagUz.image()
                    ],
                  ),
                )),
            // Spacer(),
            // SizedBox(
            //     height: 48,
            //     width: double.infinity,
            //     child: CommonButton(
            //         onPressed: () {
            //           context
            //               .read<ChangeLanguageCubit>()
            //               .saveSelectedLanguage();
            //         },
            //         child: Strings.buttonTitleSave.w(500)))
          ],
        ),
      ),
    );
  }
}

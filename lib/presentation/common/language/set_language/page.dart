import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/button/common_button.dart';

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
              CommonButton(
                  color: Color(0xFFE5E9F3),
                  onPressed: () {
                    EasyLocalization.of(context)?.setLocale(Locale('ru', 'RU'));
                    context.read<PageCubit>().setLanguage(Language.ru);
                  },
                  type: ButtonType.outlined,
                  text: SizedBox(
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Strings.languageRus.w(400).s(14).c(Color(0xFF41455F)),
                        Assets.images.pngImages.flagRu.image()
                      ],
                    ),
                  )),
              SizedBox(height: 6),
              CommonButton(
                  onPressed: () {
                    EasyLocalization.of(context)?.setLocale(Locale('uz', 'UZ'));
                    context.read<PageCubit>().setLanguage(Language.uz);
                  },
                  color: Color(0xFFE5E9F3),
                  type: ButtonType.outlined,
                  text: SizedBox(
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Strings.languageUzLat.w(400).s(14).c(Color(0xFF41455F)),
                        Assets.images.pngImages.flagUz.image()
                      ],
                    ),
                  )),
              SizedBox(height: 6),
              CommonButton(
                  onPressed: () {
                    EasyLocalization.of(context)
                        ?.setLocale(Locale('uz', 'UZK'));
                    context.read<PageCubit>().setLanguage(Language.kr);
                  },
                  color: Color(0xFFE5E9F3),
                  type: ButtonType.outlined,
                  text: SizedBox(
                    height: 48,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Strings.languageUzCyr.w(400).s(14).c(Color(0xFF41455F)),
                        Assets.images.pngImages.flagUz.image()
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

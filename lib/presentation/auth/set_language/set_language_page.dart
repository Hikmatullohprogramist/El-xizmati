import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/common_button.dart';
import 'package:onlinebozor/presentation/auth/set_language/cubit/set_language_cubit.dart';

@RoutePage()
class SetLanguagePage extends BasePage<SetLanguageCubit, SetLanguageBuildable,
    SetLanguageListenable> {
  const SetLanguagePage({super.key});

  @override
  void listener(BuildContext context, SetLanguageListenable state) {
    var log = Logger();
    log.i(state.effect);
    switch (state.effect) {
      case SetLanguageEffect.navigationAuthStart:
        context.router.push(HomeRoute());
        break;
    }
  }

  @override
  Widget builder(BuildContext context, SetLanguageBuildable state) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                Text(Strings.languageSetlanguage)
                    .w(400)
                    .s(12)
                    .c(Color(0xFF9EABBE)),
                Spacer(),
                CommonButton(
                    color: Color(0xFFE5E9F3),
                    onPressed: () {
                      context.router.push(AuthStartRoute());
                      // context.read<SetLanguageCubit>().setLanguage(Language.ru);
                    },
                    type: ButtonType.outlined,
                    child: SizedBox(
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Strings.languageRus.w(400).s(14).c(Color(0xFF41455F))
                        ],
                      ),
                    )),
                SizedBox(
                  height: 6,
                ),
                CommonButton(
                    onPressed: () {
                      context.router.push(AuthStartRoute());
                      // context.read<SetLanguageCubit>().setLanguage(Language.uz);
                    },
                    color: Color(0xFFE5E9F3),
                    type: ButtonType.outlined,
                    child: SizedBox(
                      height: 48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Strings.languageUzb.w(400).s(14).c(Color(0xFF41455F)),
                        ],
                      ),
                    ))
              ]),
        ),
      ),
    );
  }
}

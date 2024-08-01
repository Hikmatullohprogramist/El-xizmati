import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/language/language.dart';
import 'package:onlinebozor/presentation/features/common/set_region/set_region_page.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_outlined_button.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

import 'set_intro_region_cubit.dart';

@RoutePage()
class SetIntroRegionPage extends BasePage<SetIntroRegionCubit,
    SetIntroRegionState, SetIntroRegionEvent> {
  const SetIntroRegionPage({super.key});

  @override
  void onEventEmitted(BuildContext context, SetIntroRegionEvent event) {
    switch (event.type) {
      case SetIntroRegionEventType.onSkip:
        context.router.replace(HomeRoute());
      case SetIntroRegionEventType.onSet:
        context.router.replace(HomeRoute());
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, SetIntroRegionState state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.backgroundWhiteColor,
        elevation: 0,
      ),
      backgroundColor: context.backgroundWhiteColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 26),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              Strings.setIntroRegionTitle.w(600).s(20).c(context.textPrimary),
              SizedBox(height: 12),
              Strings.setIntroRegionDescription.w(400).s(14).copyWith(textAlign: TextAlign.center),
              // bottom
              Spacer(),
              CustomElevatedButton(
                text: Strings.setIntroRegionSelectButton,
                backgroundColor: StaticColors.majorelleBlue,
                onPressed: () {
                  showCupertinoModalBottomSheet(
                    context: context,
                    builder: (context) => SetRegionPage(),
                  );
                  cubit(context).setIntroRegion();
                  HapticFeedback.lightImpact();
                  // context.router.replace(HomeRoute());
                },
              ),
              SizedBox(
                height: 8,
              ),
              CustomElevatedButton(
                text: Strings.setIntroChooseLater,
                onPressed: () {
                  HapticFeedback.lightImpact();
                  cubit(context).skipIntroRegion();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

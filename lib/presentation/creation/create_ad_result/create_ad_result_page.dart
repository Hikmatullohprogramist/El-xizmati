import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/button/custom_outlined_button.dart';

import '../../../../../common/core/base_page.dart';
import '../../../common/gen/assets/assets.gen.dart';
import '../../../common/gen/localization/strings.dart';
import '../../../common/widgets/app_bar/default_app_bar.dart';
import '../../../common/widgets/button/custom_elevated_button.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class CreateAdResultPage extends BasePage<PageCubit, PageState, PageEvent> {
  const CreateAdResultPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: DefaultAppBar("", () => context.router.pop()),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 96),
            Assets.images.pngImages.adCreationResult.image(height: 120, width: 120),
            Strings.createAdResultMessage
                .w(800)
                .s(18)
                .c(context.colors.textPrimary),
            SizedBox(height: 16),
            Strings.createAdResultDesc
                .w(500)
                .s(14)
                .c(context.colors.textSecondary)
                .copyWith(textAlign: TextAlign.center),
            SizedBox(height: 42),
            CustomOutlinedButton(
              text: Strings.createAdResultEditCurrentAd,
              strokeColor: Colors.orange,
              onPressed: () async {
                context.router.replace(UserAdListRoute());
              },
            ),
            SizedBox(height: 20),
            CustomOutlinedButton(
              text: Strings.createAdResultAddAnotherAd,
              strokeColor: Colors.green,
              onPressed: () async {
                context.router.replace(CreateAdChooserRoute());
              },
            ),
            SizedBox(height: 20),
            CustomElevatedButton(
              text: Strings.createAdResultOpenProfile,
              onPressed: () async {
                context.router.replace(ProfileRoute());
              },
            ),
          ],
        ),
      ),
    );
  }
}

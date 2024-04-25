import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/colors/static_colors.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/domain/models/ad/ad_transaction_type.dart';

import '../../../../../common/core/base_page.dart';
import '../../../common/gen/assets/assets.gen.dart';
import '../../../common/gen/localization/strings.dart';
import '../../../common/widgets/app_bar/default_app_bar.dart';
import '../../../common/widgets/button/custom_elevated_button.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class CreateAdResultPage extends BasePage<PageCubit, PageState, PageEvent> {
  const CreateAdResultPage(this.adId, this.adTransactionType, {super.key});

  final int adId;
  final AdTransactionType adTransactionType;

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(adId, adTransactionType);
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: "",
        backgroundColor: context.appBarColor,
        onBackPressed: () => context.router.pop(),
      ),
      backgroundColor: context.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 96),
            Assets.images.pngImages.adCreationResult
                .image(height: 120, width: 120),
            Strings.createAdResultMessage
                .w(800)
                .s(20)
                .c(context.colors.textPrimary),
            SizedBox(height: 16),
            Strings.createAdResultDesc
                .w(500)
                .s(14)
                .c(context.colors.textSecondary)
                .copyWith(textAlign: TextAlign.center),
            SizedBox(height: 72),
            CustomElevatedButton(
              text: Strings.createAdResultEditCurrentAd,
              backgroundColor: StaticColors.bondiBlue.withOpacity(0.8),
              rightIcon: Assets.images.icActionEdit.svg(color: Colors.white),
              onPressed: () async {
                switch (adTransactionType) {
                  case AdTransactionType.SELL:
                    context.router.replace(CreateProductAdRoute(
                      adId: adId,
                      adTransactionType: adTransactionType,
                    ));
                  case AdTransactionType.FREE:
                    context.router.replace(CreateProductAdRoute(
                      adId: adId,
                      adTransactionType: adTransactionType,
                    ));
                  case AdTransactionType.EXCHANGE:
                    context.router.replace(CreateProductAdRoute(
                      adId: adId,
                      adTransactionType: adTransactionType,
                    ));
                  case AdTransactionType.SERVICE:
                    context.router.replace(CreateServiceAdRoute(adId: adId));
                  case AdTransactionType.BUY:
                    context.router.replace(CreateRequestAdRoute(
                      adId: adId,
                      adTransactionType: adTransactionType,
                    ));
                  case AdTransactionType.BUY_SERVICE:
                    context.router.replace(CreateRequestAdRoute(
                      adId: adId,
                      adTransactionType: adTransactionType,
                    ));
                }
              },
            ),
            SizedBox(height: 20),
            CustomElevatedButton(
              text: Strings.createAdResultAddAnotherAd,
              backgroundColor: StaticColors.majorelleBlue.withOpacity(0.8),
              rightIcon: Assets.images.bottomBar.addAd.svg(color: Colors.white),
              onPressed: () async {
                context.router.replace(CreateAdChooserRoute());
              },
            ),
            SizedBox(height: 20),
            CustomElevatedButton(
              text: Strings.createAdResultOpenDashboard,
              backgroundColor: StaticColors.buttonColor.withOpacity(0.8),
              rightIcon:
                  Assets.images.bottomBar.dashboard.svg(color: Colors.white),
              onPressed: () async {
                context.router.replace(DashboardRoute());
              },
            ),
          ],
        ),
      ),
    );
  }
}

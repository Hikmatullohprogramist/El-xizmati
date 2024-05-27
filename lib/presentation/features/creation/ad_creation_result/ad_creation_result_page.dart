import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/ad/ad_transaction_type.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';

import 'cubit/ad_creation_result_cubit.dart';

@RoutePage()
class AdCreationResultPage extends BasePage<PageCubit, PageState, PageEvent> {
  const AdCreationResultPage(this.adId, this.adTransactionType, {super.key});

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
        titleTextColor: context.textPrimary,
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
            Strings.adCreationResultMessage
                .w(800)
                .s(20)
                .c(context.textPrimary),
            SizedBox(height: 16),
            Strings.adCreationResultDesc
                .w(500)
                .s(14)
                .c(context.textSecondary)
                .copyWith(textAlign: TextAlign.center),
            SizedBox(height: 72),
            CustomElevatedButton(
              text: Strings.adCreationResultEditCurrentAd,
              backgroundColor: StaticColors.bondiBlue.withOpacity(0.8),
              rightIcon: Assets.images.icActionEdit.svg(color: Colors.white),
              onPressed: () async {
                switch (adTransactionType) {
                  case AdTransactionType.SELL:
                    context.router.replace(ProductAdCreationRoute(
                      adId: adId,
                      adTransactionType: adTransactionType,
                    ));
                  case AdTransactionType.FREE:
                    context.router.replace(ProductAdCreationRoute(
                      adId: adId,
                      adTransactionType: adTransactionType,
                    ));
                  case AdTransactionType.EXCHANGE:
                    context.router.replace(ProductAdCreationRoute(
                      adId: adId,
                      adTransactionType: adTransactionType,
                    ));
                  case AdTransactionType.SERVICE:
                    context.router.replace(ServiceAdCreationRoute(adId: adId));
                  case AdTransactionType.BUY:
                    context.router.replace(RequestAdCreationRoute(
                      adId: adId,
                      adTransactionType: adTransactionType,
                    ));
                  case AdTransactionType.BUY_SERVICE:
                    context.router.replace(RequestAdCreationRoute(
                      adId: adId,
                      adTransactionType: adTransactionType,
                    ));
                }
              },
            ),
            SizedBox(height: 20),
            CustomElevatedButton(
              text: Strings.adCreationResultAddAnotherAd,
              backgroundColor: StaticColors.majorelleBlue.withOpacity(0.8),
              rightIcon: Assets.images.bottomBar.addAd.svg(color: Colors.white),
              onPressed: () async {
                context.router.replace(CreateAdChooserRoute());
              },
            ),
            SizedBox(height: 20),
            CustomElevatedButton(
              text: Strings.adCreationResultOpenDashboard,
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

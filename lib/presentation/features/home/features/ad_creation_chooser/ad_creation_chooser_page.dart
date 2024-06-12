import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/ad/ad_transaction_type.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/empty_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/elevation/elevation_widget.dart';

import 'ad_creation_chooser_cubit.dart';

@RoutePage()
class AdCreationChooserPage extends BasePage<AdCreationChooserCubit,
    AdCreationChooserState, AdCreationChooserEvent> {
  const AdCreationChooserPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, AdCreationChooserState state) {
    return Scaffold(
      appBar: EmptyAppBar(
        titleText: Strings.adCreationTitle,
        backgroundColor: context.appBarColor,
        textColor: context.textPrimary,
      ),
      backgroundColor: context.backgroundGreyColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: state.isLogin
              ? [
                  _buildAdCreationBlock(context),
                  _buildRequestCreationBlock(context),
                ]
              : [
                  _buildAuthBlock(context),
                ],
        ),
      ),
    );
  }

  Widget _buildAdCreationBlock(BuildContext context) {
    return ElevationWidget(
      topLeftRadius: 16,
      topRightRadius: 16,
      bottomLeftRadius: 16,
      bottomRightRadius: 16,
      leftMargin: 16,
      topMargin: 16,
      rightMargin: 16,
      bottomMargin: 8,
      child: Container(
        padding: EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.images.pngImages.sell.image(height: 86, width: 86),
              Strings.adCreationStartSaleTitle
                  .w(800)
                  .s(18)
                  .c(context.textPrimary),
              SizedBox(height: 16),
              SafeArea(
                child: Strings.adCreationStartSaleDesc
                    .w(500)
                    .s(14)
                    .copyWith(textAlign: TextAlign.center),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      text: Strings.adCreationStartSaleProduct,
                      onPressed: () {
                        context.router.push(ProductAdCreationRoute());
                      },
                      buttonHeight: 36,
                      textSize: 12,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: CustomElevatedButton(
                      text: Strings.adCreationStartSaleService,
                      onPressed: () {
                        context.router.push(ServiceAdCreationRoute());
                      },
                      buttonHeight: 36,
                      textSize: 12,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRequestCreationBlock(BuildContext context) {
    return ElevationWidget(
      topLeftRadius: 16,
      topRightRadius: 16,
      bottomLeftRadius: 16,
      bottomRightRadius: 16,
      leftMargin: 16,
      topMargin: 8,
      rightMargin: 16,
      bottomMargin: 16,
      child: Container(
        padding: EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Assets.images.pngImages.buy.image(height: 86, width: 86),
              Strings.adCreationStartBuyTitle
                  .w(800)
                  .s(18)
                  .c(context.textPrimary),
              SizedBox(height: 16),
              Strings.adCreationStartBuyDesc
                  .w(500)
                  .s(14)
                  .copyWith(textAlign: TextAlign.center),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      text: Strings.adCreationStartBuyProduct,
                      onPressed: () {
                        context.router.push(RequestAdCreationRoute(
                          adTransactionType: AdTransactionType.buy,
                        ));
                      },
                      buttonHeight: 36,
                      textSize: 12,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: CustomElevatedButton(
                      text: Strings.adCreationStartBuyService,
                      onPressed: () {
                        context.router.push(RequestAdCreationRoute(
                          adTransactionType: AdTransactionType.buy_service,
                        ));
                      },
                      buttonHeight: 36,
                      textSize: 12,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthBlock(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 36),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 170),
            Assets.images.pngImages.adEmpty.image(),
            SizedBox(height: 48),
            Strings.authRecommentTitle
                .w(500)
                .s(20)
                .copyWith(textAlign: TextAlign.center),
            SizedBox(height: 20),
            Strings.authRecommentDesc
                .w(500)
                .s(16)
                .c(Color(0xFF41455E))
                .copyWith(textAlign: TextAlign.center),
            SizedBox(height: 120),
            SizedBox(
              width: double.maxFinite,
              child: CustomElevatedButton(
                text: Strings.authRecommentAction,
                onPressed: () {
                  context.router.push(AuthStartRoute());
                  HapticFeedback.lightImpact();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

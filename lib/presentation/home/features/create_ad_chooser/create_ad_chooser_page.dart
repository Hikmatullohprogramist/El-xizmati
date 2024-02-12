import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';

import '../../../../../../common/gen/assets/assets.gen.dart';
import '../../../../common/widgets/common/common_button.dart';
import 'cubit/create_ad_chooser_cubit.dart';

@RoutePage()
class CreateAdChooserPage extends BasePage<CreateAdChooserCubit,
    CreateAdChooserBuildable, CreateAdChooserListenable> {
  const CreateAdChooserPage({super.key});

  @override
  Widget builder(BuildContext context, CreateAdChooserBuildable state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.5,
      ),
      backgroundColor: Color(0xFFF2F4FB),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSaleBlock(context),
            _buildBuyBlock(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBuyBlock(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFE5E9F3), width: 1),
      ),
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
                .c(context.colors.textPrimary),
            SizedBox(height: 16),
            Strings.adCreationStartBuyDesc
                .w(500)
                .s(14)
                .c(context.colors.textSecondary)
                .copyWith(textAlign: TextAlign.center),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    color: context.colors.buttonPrimary,
                    type: ButtonType.elevated,
                    onPressed: () {
                      context.router.push(CreateProductOrderRoute());
                    },
                    child: Strings.adCreationStartBuyProduct
                        .s(13)
                        .w(400)
                        .c(Colors.white),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CommonButton(
                    color: context.colors.buttonPrimary,
                    type: ButtonType.elevated,
                    onPressed: () {
                      context.router.push(CreateServiceOrderRoute());
                    },
                    child: Strings.adCreationStartBuyService
                        .s(13)
                        .w(400)
                        .c(Colors.white),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSaleBlock(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFE5E9F3), width: 1),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.images.pngImages.sell.image(height: 86, width: 86),
            Strings.adCreationStartSaleTitle
                .w(800)
                .s(18)
                .c(context.colors.textPrimary),
            SizedBox(height: 16),
            SafeArea(
              child: Strings.adCreationStartSaleDesc
                  .w(500)
                  .s(14)
                  .c(context.colors.textSecondary)
                  .copyWith(textAlign: TextAlign.center),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: CommonButton(
                    color: context.colors.buttonPrimary,
                    type: ButtonType.elevated,
                    onPressed: () {
                      context.router.push(CreateProductAdRoute());
                    },
                    child: Strings.adCreationStartSaleProduct
                        .s(13)
                        .w(400)
                        .c(Colors.white)
                        .copyWith(textAlign: TextAlign.center),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: CommonButton(
                    color: context.colors.buttonPrimary,
                    type: ButtonType.elevated,
                    onPressed: () {
                      context.router.push(CreateServiceAdRoute());
                    },
                    child: Strings.adCreationStartSaleService
                        .s(13)
                        .w(400)
                        .c(Colors.white)
                        .copyWith(textAlign: TextAlign.center),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

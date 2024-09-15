import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/domain/models/ad/ad_transaction_type.dart';
import 'package:El_xizmati/presentation/router/app_router.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/widgets/app_bar/empty_app_bar.dart';
import 'package:El_xizmati/presentation/widgets/button/custom_elevated_button.dart';
import 'package:El_xizmati/presentation/widgets/elevation/elevation_widget.dart';

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
      body: Column(
        children: [
           InkWell(
              onTap: (){
                context.router.push(AdCreateRoute());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(60),
                  decoration: BoxDecoration(
                    color: context.colors.primary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.add,size: 30),
                      SizedBox(height: 10),
                      Text("E'lon yaratish").w(400).s(16),
                    ],
                  ),
                ),
              ),
            )
        ],
      )
      /*SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: state.isAuthorized
              ? [
                  _buildAdCreationBlock(context),
                  _buildRequestCreationBlock(context),
                ]
              : [
                  _buildAuthBlock(context),
                ],
        ),
      ),*/
    );
  }

}

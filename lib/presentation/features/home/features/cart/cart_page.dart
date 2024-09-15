import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/presentation/features/home/features/cart/chat/chat/chat.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/domain/models/ad/ad.dart';
import 'package:El_xizmati/presentation/router/app_router.dart';
import 'package:El_xizmati/presentation/support/colors/static_colors.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/widgets/app_bar/empty_app_bar.dart';
import 'package:El_xizmati/presentation/widgets/cart/cart_shimmer.dart';
import 'package:El_xizmati/presentation/widgets/cart/cart_widget.dart';
import 'package:El_xizmati/presentation/widgets/elevation/elevation_widget.dart';
import 'package:El_xizmati/presentation/widgets/favorite/favorite_empty_widget.dart';
import 'package:El_xizmati/presentation/widgets/loading/loader_state_widget.dart';

import 'cart_cubit.dart';

@RoutePage()
class CartPage extends BasePage<CartCubit, CartState, CartEvent> {
  const CartPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, CartState state) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(top: 10,left: 10,bottom: 5),
            child: IconButton(
              icon: Icon(Icons.menu,color: StaticColors.colorPrimary,),
              onPressed: () {
                //  cubit(context).showLogOut(true);
              },
            ),
          ),
          actions: <Widget>[

            Icon(Icons.delete,color:StaticColors.colorPrimary),
            SizedBox(width: 12),
          ],
        ),
      backgroundColor:Colors.white,
      body: _getMessages(context, state)
    );
  }


  Widget _getMessages(BuildContext context, CartState state,) {
    return  ListView.separated(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 15,
      padding: EdgeInsets.only(left: 16,right: 16),
      itemBuilder: (context, index) {
        return Container(

          height: 65,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.withOpacity(0.4)),
          ),
          child: Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey.withOpacity(0.4))
                  ),
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(10),
                  child: Assets.spImages.svgImages.robot.image()),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      "Shodlik Yagmurov".s(16).w(600).c(StaticColors.colorPrimary),
                      "15 daq".s(12).w(600).c(StaticColors.textColorPrimary)

                    ],),
                  ),
                  SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        "Assalomu alaykum. Salomatmisiz?".s(12).w(400).c(Color(0xFF7C7C7C)),
                         Container(
                           width: 20,
                           height: 20,
                           decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               color: StaticColors.colorPrimary
                           ),
                           child: Center(child: "2".s(10).w(400).c(Colors.white)),
                         )

                      ],),
                  )

                ],),
              )
            ],
          ),

        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 8);
      },
    );
  }
}

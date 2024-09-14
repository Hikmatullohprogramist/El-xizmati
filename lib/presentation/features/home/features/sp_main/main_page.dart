import 'package:El_xizmati/core/enum/enums.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/domain/models/ad/ad_list_type.dart';
import 'package:El_xizmati/presentation/features/home/features/sp_main/main_cubit.dart';
import 'package:El_xizmati/presentation/support/colors/static_colors.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/widgets/app_bar/action_app_bar.dart';
import 'package:El_xizmati/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:El_xizmati/presentation/widgets/category/popular_category_list_shimmer.dart';
import 'package:El_xizmati/presentation/widgets/category/popular_category_list_widget.dart';
import 'package:El_xizmati/presentation/widgets/dashboard/see_all_widget.dart';
import 'package:El_xizmati/presentation/widgets/loading/loader_state_widget.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../router/app_router.dart';

@RoutePage()
class MainPage extends BasePage<MainCubit, MainState, MainEvent>{
  const MainPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, MainState state) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          Icon(Icons.search,color:Colors.black87),
          SizedBox(width: 12),
          Icon(Icons.notifications,color:Colors.black87),
          SizedBox(width: 12),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Padding(
            padding: const EdgeInsets.only(left: 16,top: 10),
            child: "Kategoriya".s(16).w(400).c(Colors.grey),
          ),
          SizedBox(height: 15),
          _getPopularCategoriesWidget(context, state),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(children: [
              "Ko'p ko'rilgan".s(16).w(500).c(Colors.black),
              Spacer(),
              "Barcahsi".s(14).w(400).c(StaticColors.colorPrimary),

            ],),
          ),
          SizedBox(height: 10),
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 16),
           child: _getMoreViewed(context, state),
         ),
         


         /* InkWell(
            onTap: (){
              context.router.push(AdCreateRoute());
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(60),
              decoration: BoxDecoration(
                color: context.colors.primary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12)
              ),
              child: Text("E'lon yaratish").w(400).s(16),
            ),
          )*/
        ],
      ),
    );
  }

  Widget _getPopularCategoriesWidget(BuildContext context, MainState state,) {
    return   LoaderStateWidget(
      onRetryClicked: () {
      },
      isFullScreen: false,
      loadingState:LoadingState.success,
      loadingBody: PopularCategoryListShimmer(),
      successBody: PopularCategoryListWidget(
        categories: state.popularCategories,
        onCategoryClicked: (popularCategories) {
        },
      ),
    );
  }

  Widget _getMoreViewed(BuildContext context, MainState state,) {
    return  SizedBox(
      height: 240,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 6,
      //  padding: EdgeInsets.only(left: 16, bottom: 20, right: 16),
        itemBuilder: (context, index) {
          return Container(
            width: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.withOpacity(0.4))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 6),
               Assets.spImages.svgImages.pic.image()
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(width: 8);
        },
      ),
    );
  }

}
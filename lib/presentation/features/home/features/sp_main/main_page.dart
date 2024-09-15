import 'package:El_xizmati/core/enum/enums.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/domain/models/ad/ad_list_type.dart';
import 'package:El_xizmati/presentation/features/home/features/sp_main/main_cubit.dart';
import 'package:El_xizmati/presentation/support/colors/static_colors.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/widgets/button/custom_elevated_button.dart';
import 'package:El_xizmati/presentation/widgets/category/popular_category_list_shimmer.dart';
import 'package:El_xizmati/presentation/widgets/category/popular_category_list_widget.dart';
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
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child:  Column(
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
                _getMoreViewed(context, state),
                SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(children: [
                    "Reytingi baland".s(16).w(500).c(Colors.black),
                    Spacer(),
                    "Barcahsi".s(14).w(400).c(StaticColors.colorPrimary),

                  ],),
                ),
                SizedBox(height: 10),
                _getMoreViewed(context, state),




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
          )
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
      height: 295,
      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 6,
         padding: EdgeInsets.only(left: 16),
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
               Assets.spImages.svgImages.pic.image(),
              // Assets.spImages.svgImages.robot.image(),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(children: [
                    Container(width:25,height: 25,
                     child:Assets.spImages.svgImages.robot.image() ,
                    ),
                    SizedBox(width: 4),
                    Column(
                      children: [
                        "Shodlik Yagmurov".s(12).c(Colors.black87).w(500),
                        Row(children: [
                          "4.5".s(12).c(Colors.black87).w(500),
                          Icon(Icons.star,size: 15,color: StaticColors.colorPrimary,),
                          SizedBox(width: 2),
                          "(10+ e'lon)".s(12).c(Colors.black87).w(500),


                        ],)
                      ],
                    )
                  ],),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          "Menga santexnik kerak".s(12).c(StaticColors.colorPrimary).w(700),
                        ],
                      ),
                      SizedBox(height: 2),
                      "Lorem ipsum dolor sit amet consectetur. Uls elit vitae....".s(12).c(StaticColors.textColorPrimary).w(500),
                      SizedBox(height: 4),

                       Row(children: [
                         Row(
                           children: [
                             Assets.spImages.svgImages.icCart.svg(width: 14,height: 14),
                             SizedBox(width:5),
                             "2 mln uzs".s(10).c(StaticColors.textColorPrimary).w(500),

                           ],
                         ),
                         Spacer(),
                         Row(
                           children: [
                             Assets.spImages.svgImages.icBag.svg(width: 14,height: 14),
                             SizedBox(width:5),
                             "Bir martalik".s(10).c(StaticColors.textColorPrimary).w(500),

                           ],
                         )
                       ],),
                      SizedBox(height: 6
                      ),

                       Row(children: [
                         Row(
                           children: [
                             Assets.spImages.svgImages.icMarker.svg(width: 14,height: 14),
                             SizedBox(width:5),
                             "Urgench".s(11).c(StaticColors.textColorPrimary).w(500),

                           ],
                         ),
                         Spacer(),
                         Row(
                           children: [
                             Assets.spImages.svgImages.icDate.svg(width: 14,height: 14),
                             SizedBox(width:5),
                             "8.08.2024".s(11).c(StaticColors.textColorPrimary).w(500),

                           ],
                         )
                       ],)
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: CustomElevatedButton(
                    buttonHeight: 40,
                    text: "Ba'tafsil",
                    onPressed: () {
                    },
                    backgroundColor: Color(0xFF703EDB).withAlpha(50),
                  ),
                )





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
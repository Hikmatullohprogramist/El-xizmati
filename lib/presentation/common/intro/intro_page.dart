

import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/presentation/common/intro/features/intro_page_1.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../common/core/base_page.dart';
import 'package:onlinebozor/presentation/common/intro/cubit/page_cubit.dart';

import 'features/intro_page_2.dart';
import 'features/intro_page_3.dart';



@RoutePage()
class IntroPage extends BasePage<PageCubit, PageState, PageEvent> {
  const IntroPage({
    super.key,
  });


  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    PageController _controller=PageController();
    bool onLastPage=false;
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.red,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index){
              onLastPage=(index==2);
            },
            children: [
             IntroPage1(),
             IntroPage2(),
             IntroPage3(),

            ],
          ),
          Container(
            alignment: Alignment(0,0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    _controller.jumpToPage(2);
                  },
                    child: Text("skip")
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                ),
                onLastPage
                 ? InkWell(
                    onTap: (){
                      ////****
                    },
                    child: Text("Done")
                ):
                InkWell(
                    onTap: (){
                      _controller.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    child: Text("next")
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

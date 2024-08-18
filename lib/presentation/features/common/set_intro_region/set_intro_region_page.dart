import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_outlined_button.dart';

import 'set_intro_region_cubit.dart';

@RoutePage()
class SetIntroRegionPage extends BasePage<SetIntroRegionCubit,
    SetIntroRegionState, SetIntroRegionEvent> {
  SetIntroRegionPage({super.key});
  @override
  void onEventEmitted(BuildContext context, SetIntroRegionEvent event) {
    switch (event.type) {
      case SetIntroRegionEventType.onSkip:
        context.router.replace(HomeRoute());
      case SetIntroRegionEventType.onSet:
        context.router.replace(HomeRoute());
    }
  }
  @override
  Widget onWidgetBuild(BuildContext context, SetIntroRegionState state) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: context.backgroundWhiteColor,
          elevation: 0,
          centerTitle: true,
          title: SizedBox(
            width: 200,
            child: TabBar(
              labelPadding: EdgeInsets.all(0),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.transparent,
              labelColor: context.colors.buttonPrimary,
              indicator: BoxDecoration(
                  color: context.colors.buttonPrimary,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              tabs: [
                tab(context),
                tab(context),
                tab(context),
              ],
            ),
          ),
        ),
        backgroundColor: context.backgroundWhiteColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(bottom: 88, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: TabBarView(
                  children: [
                    intro(
                        context,
                        'El Xizmati tizimimizga xush kelibsiz!',
                        'El Xizmati ishchilar va ish beruv-\nchilarni bir joyga ja’mlagan hamjamiyat platformasidir.',
                        Assets.images.intro1),
                    intro(
                        context,
                        'Endi ishingizni yaqin atrofdan toping!',
                        'Kiritilgan lokatsiya orqali endilikda siz uyingizdan uzoq bo’lmagan hududlardan ish topasiz!',
                        Assets.images.intro2),
                    intro(
                        context,
                        'Barcha shaxsiy ma’lumotlaringiz ximoyalangan!',
                        'Shaxsiy ma’lumotlaringiz, to’lovlaringiz, sizning ruxsatingizsiz hech kimga berilmaydi.',
                        Assets.images.intro3),
                  ],
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: CustomElevatedButton(
                    text: 'Davom etish',
                    onPressed: () {

                    },
                    rightIcon: Icon(
                      Icons.arrow_forward,
                      size: 18,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35.0),
                  child: CustomOutlinedButton(
                      text: "O'tkazib yuborish",
                      onPressed: () {
                        cubit(context).skipIntroRegion();
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column intro(
      BuildContext context, String title, String subtitle, SvgGenImage svg) {
    return Column(

      children: [
        svg.svg(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.9),
        SizedBox(height: 40),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              title,
              textAlign: TextAlign.center,
            ).w(800).s(32).c(Color(0xFF2A174E))),
        SizedBox(height: 20),
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              subtitle,
              textAlign: TextAlign.center,
            ).w(300).s(16).c(Color(0xFF2A174E))),
      ],
    );
  }

  Container tab(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width * 0.1,
        height: 8,
        decoration: BoxDecoration(
            color: Color(0xFF703EDB).withOpacity(0.3),
            borderRadius: BorderRadius.circular(12)),
      );
}

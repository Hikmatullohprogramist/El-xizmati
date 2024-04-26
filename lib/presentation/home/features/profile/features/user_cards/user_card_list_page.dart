import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/app_bar/action_app_bar.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/common/widgets/button/custom_text_button.dart';

import '../../../../../../common/router/app_router.dart';
import '../../../../../../common/widgets/card/card_empty_widget.dart';
import '../../../../../../common/widgets/card/card_widget.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class UserCardListPage extends BasePage<PageCubit, PageState, PageEvent> {
  const UserCardListPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
      appBar: ActionAppBar(
        titleText: Strings.myCardTitle,
        onBackPressed: () => context.router.pop(),
        actions: [
          CustomTextButton(
            text: Strings.cardAddTitle,
            onPressed: () {
              // context.router.push(AddCardRoute());
            },
          )
        ],
      ),
      body: Column(children: [
        if (state.isEmpty)
          CardEmptyWidget(
            onActionClicked: () {
              // context.router.push(AddCardRoute());
            },
          )
        else
          CardWidget(
            image: "8a818006f6ddda2c7af7dbf4",
            listener: () {},
            listenerEdit: () {},
          )
      ]),
    );
  }

  void edit(BuildContext context, PageState state) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: context.backgroundColor,
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            height: 320,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                Row(
                  children: [
                    Expanded(
                        child: Center(
                            child:
                                "Действие".w(500).s(16).c(Color(0xFF41455E)))),
                    IconButton(
                        onPressed: () {},
                        icon: Assets.images.icClose.svg(width: 24, height: 24))
                  ],
                ),
                SizedBox(width: 32),
                InkWell(
                  onTap: () {},
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Assets.images.icEdit.svg(width: 24, height: 24),
                          SizedBox(width: 10),
                          "Редактировать".w(500).s(14).c(Color(0xFF5C6AC3))
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Assets.images.icStar.svg(
                              width: 24,
                              height: 24,
                              color: context.colors.iconGrey),
                          SizedBox(width: 10),
                          Strings.actionMakeMain
                              .w(500)
                              .s(14)
                              .c(Color(0xFF41455E))
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Assets.images.icDelete.svg(width: 24, height: 24),
                          SizedBox(width: 10),
                          "Удалить карту".w(500).s(14).c(Color(0xFF5C6AC3))
                        ],
                      )),
                ),
                SizedBox(height: 24),
                SizedBox(
                  height: 42,
                  width: double.infinity,
                  child: CustomElevatedButton(
                    text: Strings.commonClose,
                    onPressed: () {},
                  ),
                )
              ]),
            ),
          );
        });
  }
}

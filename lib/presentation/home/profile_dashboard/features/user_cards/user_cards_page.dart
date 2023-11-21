import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/widgets/card_widget.dart';
import 'package:onlinebozor/common/widgets/common_button.dart';

import '../../../../../common/router/app_router.dart';
import 'cubit/user_cards_cubit.dart';

@RoutePage()
class UserCardsPage
    extends BasePage<UserCardsCubit, UserCardsBuildable, UserCardsListenable> {
  const UserCardsPage({super.key});

  @override
  Widget builder(BuildContext context, UserCardsBuildable state) {
    void _edit() {
      showModalBottomSheet(
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: Colors.white,
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
                              child: "Действие"
                                  .w(500)
                                  .s(16)
                                  .c(Color(0xFF41455E)))),
                      IconButton(
                          onPressed: () {},
                          icon:
                              Assets.images.icClose.svg(width: 24, height: 24))
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
                            "Сделать основным".w(500).s(14).c(Color(0xFF41455E))
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
                    child: CommonButton(
                      onPressed: () {},
                      child: "Закрыть".w(600).s(14).c(Colors.white),
                    ),
                  )
                ]),
              ),
            );
          });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: 'Мои карты'.w(500).s(14).c(context.colors.textPrimary),
        centerTitle: true,
        elevation: 0,
        actions: [
          CommonButton(
              type: ButtonType.text,
              onPressed: () => context.router.push(AddCardRoute()),
              child: "Добавить".w(500).s(12).c(Color(0xFF5C6AC3)))
        ],
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: Column(children: [
        // if (state.isEmpty)
        //   CardEmptyWidget(
        //     callBack: () {
        //       context.router.push(AddCardRoute());
        //     },
        //   )
        // else
        CardWidget(
            onClick: () {},
            image: "8a818006f6ddda2c7af7dbf4",
            onClickSetting: () {
              _edit();
            })
      ]),
    );
  }
}

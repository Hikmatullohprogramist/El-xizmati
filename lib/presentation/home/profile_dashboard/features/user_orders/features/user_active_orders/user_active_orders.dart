import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/widgets/common_button.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/user_orders/features/user_active_orders/cubit/user_active_orders_cubit.dart';

import '../../../../../../../common/core/base_page.dart';
import '../../../../../../../common/widgets/ad_empty_widget.dart';

@RoutePage()
class UserActiveOrdersPage extends BasePage<UserActiveOrdersCubit,
    UserActiveOrdersBuildable, UserActiveOrdersListenable> {
  const UserActiveOrdersPage({super.key});

  @override
  Widget builder(BuildContext context, UserActiveOrdersBuildable state) {
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
              height: 380,
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
                            Assets.images.icEdit.svg(width: 24, height: 24),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Нет в налачии"
                                    .w(500)
                                    .s(14)
                                    .c(Color(0xFF41455E)),
                                SizedBox(height: 4),
                                "(временно убрать из маркета)"
                                    .w(400)
                                    .s(12)
                                    .c(Color(0xFF9EABBE))
                              ],
                            ),
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
                            Assets.images.icEdit.svg(width: 24, height: 24),
                            SizedBox(width: 10),
                            "Рекламировать".w(500).s(14).c(Color(0xFF5C6AC3))
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
                            "Деактивировать".w(500).s(14).c(Color(0xFF5C6AC3))
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

    void filter() {
      showModalBottomSheet(
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          backgroundColor: Colors.white,
          context: context,
          builder: (BuildContext buildContext) {
            return Container(
              height: 380,
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      "Сбросить".w(500).s(12).c(Color(0xFF5C6AC3)),
                      "Фильтр".w(500).s(16).c(Color(0xFF41455E)),
                      IconButton(
                          onPressed: () {},
                          icon:
                              Assets.images.icClose.svg(width: 24, height: 24))
                    ],
                  ),
                  SizedBox(height: 24),
                  "Сортировка".w(500).s(14).c(Color(0xFF41455E)),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Color(0xFFFAF9FF))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Выбрать".w(600).s(14).c(Color(0xFF9EABBE)),
                          Icon(Icons.keyboard_arrow_down)
                        ]),
                  ),
                  SizedBox(height: 20),
                  "Сортировка".w(500).s(14).c(Color(0xFF41455E)),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: Color(0xFFFAF9FF))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Все категории".w(600).s(14).c(Color(0xFF9EABBE)),
                          Icon(Icons.keyboard_arrow_down)
                        ]),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    height: 42,
                    width: double.infinity,
                    child: CommonButton(
                      onPressed: () {},
                      child: "Закрыть".w(600).s(14),
                    ),
                  )
                ]),
              ),
            );
          });
    }

    return Scaffold(
      body: Center(
        child: AdEmptyWidget(
          callBack: () {},
        ),
      ),
    );

    // return Scaffold(
    //   body: UserAd(
    //     editClick: () {
    //       _edit();
    //     },
    //     onClick: () {
    //       context.router.push(UserAdDetailRoute());
    //     },
    //   ),
    // );
  }
}

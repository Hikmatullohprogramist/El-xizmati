import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/address/address_widget.dart';
import 'package:onlinebozor/common/widgets/app_diverder.dart';
import 'package:onlinebozor/presentation/home/profile_dashboard/features/user_address/cubit/user_addresses_cubit.dart';

import '../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../common/widgets/common_button.dart';

@RoutePage()
class UserAddressesPage extends BasePage<UserAddressesCubit,
    UserAddressesBuildable, UserAddressesListenable> {
  const UserAddressesPage({super.key});

  @override
  Widget builder(BuildContext context, UserAddressesBuildable state) {
    Widget stateWidget() {
      if (10 / 5 != 2) {
        return Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Assets.images.pngImages.userAddresses.image(),
            SizedBox(height: 36),
            "Вы ещё не добавили адрес,\n хотите добавить?"
                .w(600)
                .s(16)
                .c(Color(0xFF41455E))
                .copyWith(textAlign: TextAlign.center),
            SizedBox(height: 36),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    backgroundColor: context.colors.buttonPrimary),
                onPressed: () {
                  context.router.push(AddAddressRoute());
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    SizedBox(width: 10),
                    "Добавить карту".w(600).s(14).c(Colors.white)
                  ],
                ))
          ]),
        );
      } else {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return AppAddressWidgets(
              callback: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Alert'),
                      content: Text('This is an alert dialog.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Perform action
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return AppDivider();
          },
          itemCount: 10,
        );
      }
    }

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
          actions: [
            CommonButton(
                type: ButtonType.text,
                onPressed: () => context.router.push(AddAddressRoute()),
                child: "Добавить".w(500).s(12).c(Color(0xFF5C6AC3)))
          ],
          backgroundColor: Colors.white,
          title: 'Мои адреса'.w(500).s(14).c(context.colors.textPrimary),
          centerTitle: true,
          elevation: 0.5,
          leading: IconButton(
            icon: Assets.images.icArrowLeft.svg(),
            onPressed: () => context.router.pop(),
          ),
        ),
        body: stateWidget());
  }
}

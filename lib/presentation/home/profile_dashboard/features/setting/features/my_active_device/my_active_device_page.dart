import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/active_device_widgets.dart';
import 'package:onlinebozor/common/widgets/app_diverder.dart';
import 'package:onlinebozor/common/widgets/common_button.dart';

import '../../../../../../../common/gen/assets/assets.gen.dart';
import 'cubit/my_active_device_cubit.dart';

@RoutePage()
class MyActiveDevicePage extends BasePage<MyActiveDeviceCubit,
    MyActiveDeviceBuildable, MyActiveDeviceListenable> {
  const MyActiveDevicePage({super.key});

  @override
  Widget builder(BuildContext context, MyActiveDeviceBuildable state) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: 'Активные сеансы'.w(500).s(14).c(context.colors.textPrimary),
          centerTitle: true,
          elevation: 0.5,
          leading: IconButton(
            icon: Assets.images.icArrowLeft.svg(),
            onPressed: () => context.router.pop(),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) =>
                      AppDivider(),
                  separatorBuilder: (BuildContext context, int index) =>
                      ActiveDeviceWidget(),
                  itemCount: 5),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CommonButton(
                color: Color(0xFFF66412),
                type: ButtonType.outlined,
                  onPressed: () {}, child: "Завершить все сеансы".w(600)),
            ),
            SizedBox(height: 16),
          ],
        ));
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/common/common_button.dart';
import 'package:onlinebozor/common/widgets/device/active_device_widgets.dart';
import 'package:onlinebozor/data/responses/device/active_device_response.dart';
import 'package:onlinebozor/presentation/home/features/profile_dashboard/features/setting/features/user_active_device/cubit/user_active_device_cubit.dart';

import '../../../../../../../../common/gen/assets/assets.gen.dart';

@RoutePage()
class UserActiveDevicePage extends BasePage<UserActiveDeviceCubit,
    UserActiveDeviceBuildable, UserActiveDeviceListenable> {
  const UserActiveDevicePage({super.key});

  @override
  Widget builder(BuildContext context, UserActiveDeviceBuildable state) {
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Strings.settingsActiveDevices
              .w(500)
              .s(14)
              .c(context.colors.textPrimary),
          centerTitle: true,
          elevation: 0.5,
          leading: IconButton(
            icon: Assets.images.icArrowLeft.svg(),
            onPressed: () => context.router.pop(),
          ),
        ),
        body: PagedGridView<int, ActiveDeviceResponse>(
            physics: BouncingScrollPhysics(),
            pagingController: state.devicesPagingController!,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: width / height,
              crossAxisSpacing: 16,
              mainAxisSpacing: 0,
              mainAxisExtent: 145,
              crossAxisCount: 1,
            ),
            builderDelegate: PagedChildBuilderDelegate<ActiveDeviceResponse>(
              firstPageErrorIndicatorBuilder: (_) {
                return SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: Center(
                        child: Column(
                      children: [
                        Strings.loadingStateError
                            .w(400)
                            .s(14)
                            .c(context.colors.textPrimary),
                        SizedBox(height: 12),
                        CommonButton(
                            onPressed: () {},
                            type: ButtonType.elevated,
                            child: Strings.loadingStateRetrybutton.w(400).s(15))
                      ],
                    )));
              },
              firstPageProgressIndicatorBuilder: (_) {
                return SizedBox(
                  height: 60,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                );
              },
              noItemsFoundIndicatorBuilder: (_) {
                return Center(child: Text(Strings.loadingStateNotitemfound));
              },
              newPageProgressIndicatorBuilder: (_) {
                return SizedBox(
                  height: 60,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                );
              },
              newPageErrorIndicatorBuilder: (_) {
                return SizedBox(
                  height: 60,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                );
              },
              transitionDuration: Duration(milliseconds: 100),
              itemBuilder: (context, item, index) {
                return ActiveDeviceWidget(
                    invoke: (response) {
                      context
                          .read<UserActiveDeviceCubit>()
                          .removeActiveDevice(response);
                    },
                    response: item);
              },
            )));
  }
}

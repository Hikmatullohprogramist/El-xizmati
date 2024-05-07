import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/core/colors/color_extension.dart';
import 'package:onlinebozor/core/cubit/base_page.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/active_sessions/active_session.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/device/active_session_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/device/active_session_widget.dart';

import 'cubit/page_cubit.dart';

@RoutePage()
class UserActiveSessionsPage extends BasePage<PageCubit, PageState, PageEvent> {
  const UserActiveSessionsPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
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
      body: PagedGridView<int, ActiveSession>(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        pagingController: state.controller!,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: width / height,
          crossAxisSpacing: 16,
          mainAxisSpacing: 0,
          mainAxisExtent: 145,
          crossAxisCount: 1,
        ),
        builderDelegate: PagedChildBuilderDelegate<ActiveSession>(
          firstPageErrorIndicatorBuilder: (_) {
            return SizedBox(
                height: 60,
                width: double.infinity,
                child: Center(
                    child: Column(
                  children: [
                    Strings.commonEmptyMessage
                        .w(400)
                        .s(14)
                        .c(context.colors.textPrimary),
                    SizedBox(height: 12),
                    CustomElevatedButton(
                      text: Strings.commonRetry,
                      onPressed: () {},
                    )
                  ],
                )));
          },
          firstPageProgressIndicatorBuilder: (_) {
            return SingleChildScrollView(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 14,
                itemBuilder: (BuildContext context, int index) {
                  return ActiveDeviceShimmer();
                },
              ),
            );
          },
          noItemsFoundIndicatorBuilder: (_) {
            return Center(child: Text(Strings.commonEmptyMessage));
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
            return ActiveSessionWidget(
              session: item,
              onClicked: (session) {
                cubit(context).removeActiveDevice(session);
              },
            );
          },
        ),
      ),
    );
  }
}

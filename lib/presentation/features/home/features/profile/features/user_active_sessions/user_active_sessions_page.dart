import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/domain/models/active_sessions/active_session.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/widgets/loading/default_error_widget.dart';
import 'package:El_xizmati/presentation/widgets/session/active_session_shimmer.dart';
import 'package:El_xizmati/presentation/widgets/session/active_session_widget.dart';

import 'user_active_sessions_cubit.dart';

@RoutePage()
class UserActiveSessionsPage extends BasePage<UserActiveSessionsCubit,
    UserActiveSessionsState, UserActiveSessionsEvent> {
  const UserActiveSessionsPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, UserActiveSessionsState state) {
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.backgroundGreyColor,
        title:
            Strings.settingsActiveDevices.w(500).s(14).c(context.textPrimary),
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
        showNewPageProgressIndicatorAsGridChild: false,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: width / height,
          crossAxisSpacing: 16,
          mainAxisSpacing: 0,
          mainAxisExtent: 145,
          crossAxisCount: 1,
        ),
        builderDelegate: PagedChildBuilderDelegate<ActiveSession>(
          firstPageErrorIndicatorBuilder: (_) {
            return DefaultErrorWidget(
              isFullScreen: true,
              onRetryClicked: () => cubit(context).states.controller?.refresh(),
            );
          },
          firstPageProgressIndicatorBuilder: (_) {
            return SingleChildScrollView(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (BuildContext context, int index) {
                  return ActiveSessionShimmer();
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
            return DefaultErrorWidget(
              isFullScreen: false,
              onRetryClicked: () => cubit(context).states.controller?.refresh(),
            );
          },
          transitionDuration: Duration(milliseconds: 100),
          itemBuilder: (context, item, index) {
            return SizedBox(
              height: 120,
              child: ActiveSessionWidget(
                session: item,
                onTerminateClicked: (session) {
                  showYesNoBottomSheet(
                    context,
                    title: Strings.activeSessionsTerminateTitle,
                    message: Strings.activeSessionsTerminateMessage,
                    noTitle: Strings.commonCancel,
                    onNoClicked: () {},
                    yesTitle: Strings.activeSessionsTerminate,
                    onYesClicked: () => cubit(context).removeActiveSession(session),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/notification/notification.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/action_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/elevation/elevation_widget.dart';
import 'package:onlinebozor/presentation/widgets/loading/default_empty_widget.dart';
import 'package:onlinebozor/presentation/widgets/loading/default_error_widget.dart';
import 'package:onlinebozor/presentation/widgets/notification/app_notification_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/notification/app_notification_widget.dart';

import 'notification_list_cubit.dart';

@RoutePage()
class NotificationListPage extends BasePage<NotificationListCubit,
    NotificationListState, NotificationListEvent> {
  const NotificationListPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, NotificationListState state) {
    return Scaffold(
      backgroundColor: context.backgroundGreyColor,
      appBar: ActionAppBar(
        titleText: Strings.notificationTitle,
        titleTextColor: context.textPrimary,
        backgroundColor: context.appBarColor,
        onBackPressed: () => context.router.pop(),
      ),
      body: RefreshIndicator(
        displacement: 80,
        strokeWidth: 3,
        color: StaticColors.colorPrimary,
        onRefresh: () async {
          cubit(context).states.controller!.refresh();
        },
        child: PagedListView<int, AppNotification>(
          shrinkWrap: true,
          addAutomaticKeepAlives: true,
          // physics: BouncingScrollPhysics(),
          pagingController: state.controller!,
          padding: EdgeInsets.only(top: 12, bottom: 12),
          builderDelegate: PagedChildBuilderDelegate<AppNotification>(
              firstPageErrorIndicatorBuilder: (_) {
                return DefaultErrorWidget(
                  isFullScreen: true,
                  onRetryClicked: () =>
                      cubit(context).states.controller?.refresh(),
                );
              },
              firstPageProgressIndicatorBuilder: (_) {
                return SingleChildScrollView(
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return AppNotificationShimmer();
                    },
                  ),
                );
              },
              noItemsFoundIndicatorBuilder: (_) {
                return DefaultEmptyWidget(
                  isFullScreen: true,
                  icon: Assets.images.pngImages.adEmpty.image(),
                  message: Strings.noHaveNotification,
                  onReloadClicked: () {
                    cubit(context).states.controller?.refresh();
                  },
                );
              },
              newPageProgressIndicatorBuilder: (_) {
                return SizedBox(
                  height: 220,
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.blue),
                  ),
                );
              },
              newPageErrorIndicatorBuilder: (_) {
                return DefaultErrorWidget(
                  isFullScreen: false,
                  onRetryClicked: () =>
                      cubit(context).states.controller?.refresh(),
                );
              },
              transitionDuration: Duration(milliseconds: 100),
              itemBuilder: (context, item, index) {
                return ElevationWidget(
                  topLeftRadius: 8,
                  topRightRadius: 8,
                  bottomLeftRadius: 8,
                  bottomRightRadius: 8,
                  leftMargin: 16,
                  topMargin: 6,
                  rightMargin: 16,
                  bottomMargin: 6,
                  child: AppNotificationWidget(
                    notification: item,
                    onClicked: () {
                      cubit(context).markAsRead(item);
                    },
                  ),
                );
              }),
        ),
      ),
    );
  }
}

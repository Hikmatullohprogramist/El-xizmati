import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/ad/ad_action.dart';
import 'package:onlinebozor/domain/models/ad/ad_transaction_type.dart';
import 'package:onlinebozor/domain/models/ad/user_ad.dart';
import 'package:onlinebozor/domain/models/ad/user_ad_status.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/extensions/resource_exts.dart';
import 'package:onlinebozor/presentation/widgets/action/action_list_item.dart';
import 'package:onlinebozor/presentation/widgets/ad/user_ad/user_ad_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/ad/user_ad/user_ad_widget.dart';
import 'package:onlinebozor/presentation/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:onlinebozor/presentation/widgets/elevation/elevation_widget.dart';
import 'package:onlinebozor/presentation/widgets/loading/default_empty_widget.dart';
import 'package:onlinebozor/presentation/widgets/loading/default_error_widget.dart';

import 'user_ad_list_cubit.dart';

@RoutePage()
class UserAdListPage
    extends BasePage<UserAdListCubit, UserAdListState, UserAdListEvent> {
  final UserAdStatus userAdStatus;

  const UserAdListPage({
    super.key,
    required this.userAdStatus,
  });

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(userAdStatus);
  }

  @override
  Widget onWidgetBuild(BuildContext context, UserAdListState state) {
    return Scaffold(
      backgroundColor: context.backgroundGreyColor,
      body: RefreshIndicator(
        displacement: 160,
        strokeWidth: 3,
        color: StaticColors.colorPrimary,
        onRefresh: () async {
          cubit(context).states.controller!.refresh();
        },
        child: PagedListView<int, UserAd>(
          shrinkWrap: true,
          addAutomaticKeepAlives: true,
          physics: BouncingScrollPhysics(),
          pagingController: state.controller!,
          padding: EdgeInsets.only(top: 12, bottom: 12),
          builderDelegate: PagedChildBuilderDelegate<UserAd>(
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
                      return UserAdWidgetShimmer();
                    },
                  ),
                );
              },
              noItemsFoundIndicatorBuilder: (_) {
                return DefaultEmptyWidget(
                  isFullScreen: true,
                  icon: Assets.images.pngImages.adEmpty.image(),
                  message: state.userAdStatus.getLocalizedEmptyMessage(),
                  mainActionLabel: Strings.adCreationTitle,
                  onMainActionClicked: () {
                    context.router.push(AdCreationChooserRoute());
                  },
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
                  child: UserAdWidget(
                    onActionClicked: () {
                      _showActionsBottomSheet(context, item);
                    },
                    onItemClicked: () {
                      context.router.push(UserAdDetailRoute(userAd: item));
                    },
                    userAd: item,
                  ),
                );
              }),
        ),
      ),
    );
  }

  void _showActionsBottomSheet(BuildContext context, UserAd ad) {
    AdTransactionType type = ad.adTransactionType;

    showCupertinoModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Material(
          child: Container(
            decoration: BoxDecoration(
              color: context.bottomSheetColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 12),
                BottomSheetTitle(
                  title: Strings.actionTitle,
                  onCloseClicked: () {
                    context.router.pop();
                  },
                ),
                SizedBox(height: 16),
                ActionListItem(
                  item: AdAction.ACTION_EDIT,
                  title: AdAction.ACTION_EDIT.getLocalizedName(),
                  icon: AdAction.ACTION_EDIT.getActionIcon(),
                  onClicked: (item) {
                    context.router.pop();

                    switch (type) {
                      case AdTransactionType.sell:
                        context.router.push(ProductAdCreationRoute(
                          adId: ad.id,
                          adTransactionType: type,
                        ));
                      case AdTransactionType.free:
                        context.router.push(ProductAdCreationRoute(
                          adId: ad.id,
                          adTransactionType: type,
                        ));
                      case AdTransactionType.exchange:
                        context.router.push(ProductAdCreationRoute(
                          adId: ad.id,
                          adTransactionType: type,
                        ));
                      case AdTransactionType.service:
                        context.router.push(ServiceAdCreationRoute(
                          adId: ad.id,
                        ));
                      case AdTransactionType.buy:
                        context.router.push(RequestAdCreationRoute(
                          adId: ad.id,
                          adTransactionType: type,
                        ));
                      case AdTransactionType.buy_service:
                        context.router.push(RequestAdCreationRoute(
                          adId: ad.id,
                          adTransactionType: type,
                        ));
                    }
                  },
                ),
                if (ad.isCanAdvertise())
                  ActionListItem(
                    item: AdAction.ACTION_ADVERTISE,
                    title: AdAction.ACTION_ADVERTISE.getLocalizedName(),
                    icon: AdAction.ACTION_ADVERTISE.getActionIcon(),
                    color: Colors.purpleAccent,
                    onClicked: (item) {
                      context.router.pop();
                    },
                  ),
                if (ad.isCanDeactivate())
                  ActionListItem(
                    item: AdAction.ACTION_DEACTIVATE,
                    title: AdAction.ACTION_DEACTIVATE.getLocalizedName(),
                    icon: AdAction.ACTION_DEACTIVATE.getActionIcon(),
                    color: Color(0xFFFA6F5D),
                    onClicked: (item) {
                      context.router.pop();
                      cubit(context).deactivateAd(ad);
                    },
                  ),
                if (ad.isCanActivate())
                  ActionListItem(
                    item: AdAction.ACTION_ACTIVATE,
                    title: AdAction.ACTION_ACTIVATE.getLocalizedName(),
                    icon: AdAction.ACTION_ACTIVATE.getActionIcon(),
                    onClicked: (item) {
                      context.router.pop();
                      cubit(context).activateAd(ad);
                    },
                  ),
                if (ad.isCanDelete())
                  ActionListItem(
                    item: AdAction.ACTION_DELETE,
                    title: AdAction.ACTION_DELETE.getLocalizedName(),
                    icon: AdAction.ACTION_DELETE.getActionIcon(),
                    color: Color(0xFFFA6F5D),
                    onClicked: (item) {
                      context.router.pop();
                      showYesNoBottomSheet(
                        context,
                        title: Strings.messageTitleWarning,
                        message: Strings.adDeleteMessage,
                        noTitle: Strings.commonNo,
                        onNoClicked: () {
                          Navigator.pop(context);
                          HapticFeedback.lightImpact();
                        },
                        yesTitle: Strings.commonYes,
                        onYesClicked: () {
                          Navigator.pop(context);
                          HapticFeedback.lightImpact();
                          cubit(context).deleteAd(ad);
                        },
                      );
                    },
                  ),
                SizedBox(height: 20)
              ],
            ),
          ),
        );
      },
    );
  }
}

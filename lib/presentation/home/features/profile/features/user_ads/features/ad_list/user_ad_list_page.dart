import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/action/action_list_item.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/common/widgets/loading/default_empty_widget.dart';
import 'package:onlinebozor/domain/models/ad/ad_action.dart';
import 'package:onlinebozor/domain/models/ad/ad_transaction_type.dart';
import 'package:onlinebozor/domain/models/ad/user_ad_status.dart';
import 'package:onlinebozor/presentation/home/features/dashboard/dashboard_page.dart';
import 'package:onlinebozor/presentation/utils/resource_exts.dart';

import '../../../../../../../../common/colors/static_colors.dart';
import '../../../../../../../../common/gen/localization/strings.dart';
import '../../../../../../../../common/widgets/ad/user_ad/user_ad_shimmer.dart';
import '../../../../../../../../common/widgets/ad/user_ad/user_ad_widget.dart';
import '../../../../../../../../common/widgets/bottom_sheet/bottom_sheet_title.dart';
import '../../../../../../../../domain/models/ad/user_ad.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class UserAdListPage extends BasePage<PageCubit, PageState, PageEvent> {
  const UserAdListPage({
    super.key,
    required this.userAdStatus,
  });

  final UserAdStatus userAdStatus;

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(userAdStatus);
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      backgroundColor: context.backgroundColor,
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
              return SizedBox(
                height: 100,
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
                  ),
                ),
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
                mainActionLabel: Strings.adCreateTitle,
                onMainActionClicked: () {
                  context.router.push(CreateAdChooserRoute());
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
              return SizedBox(
                height: 220,
                child: Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                ),
              );
            },
            transitionDuration: Duration(milliseconds: 100),
            itemBuilder: (context, item, index) => UserAdWidget(
              onActionClicked: () {
                _showActionsBottomSheet(context, item);
              },
              onItemClicked: () {
                context.router.push(UserAdDetailRoute(userAd: item));
              },
              userAd: item,
            ),
          ),
        ),
      ),
    );
  }

  void _showActionsBottomSheet(BuildContext context, UserAd ad) {
    // AdTransactionType type = ad.type_status.toAdTypeStatus();
    AdTransactionType type = ad.adTransactionType ?? AdTransactionType.SELL;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          decoration: BoxDecoration(
            color: context.primaryContainer,
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
                    case AdTransactionType.SELL:
                      context.router.push(CreateProductAdRoute(
                        adId: ad.id,
                        adTransactionType: type,
                      ));
                    case AdTransactionType.FREE:
                      context.router.push(CreateProductAdRoute(
                        adId: ad.id,
                        adTransactionType: type,
                      ));
                    case AdTransactionType.EXCHANGE:
                      context.router.push(CreateProductAdRoute(
                        adId: ad.id,
                        adTransactionType: type,
                      ));
                    case AdTransactionType.SERVICE:
                      context.router.push(CreateServiceAdRoute(
                        adId: ad.id,
                      ));
                    case AdTransactionType.BUY:
                      context.router.push(CreateRequestAdRoute(
                        adId: ad.id,
                        adTransactionType: type,
                      ));
                    case AdTransactionType.BUY_SERVICE:
                      context.router.push(CreateRequestAdRoute(
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
                    cubit(context).deleteAd(ad);
                  },
                ),
              SizedBox(height: 20)
            ],
          ),
        );
      },
    );
  }
}

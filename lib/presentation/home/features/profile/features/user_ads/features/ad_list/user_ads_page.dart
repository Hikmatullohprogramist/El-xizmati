import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/domain/models/ad/user_ad_status.dart';
import 'package:onlinebozor/presentation/ad/ad_list_actions/ad_list_actions.dart';

import '../../../../../../../../common/colors/static_colors.dart';
import '../../../../../../../../common/gen/localization/strings.dart';
import '../../../../../../../../common/widgets/ad/user_ad.dart';
import '../../../../../../../../common/widgets/ad/user_ad_empty_widget.dart';
import '../../../../../../../../common/widgets/ad/user_ad_shimmer.dart';
import '../../../../../../../../common/widgets/button/common_button.dart';
import '../../../../../../../../data/responses/user_ad/user_ad_response.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class UserAdsPage extends BasePage<PageCubit, PageState, PageEvent> {
  const UserAdsPage({
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
      backgroundColor: StaticColors.backgroundColor,
      body: PagedListView<int, UserAdResponse>(
        shrinkWrap: true,
        addAutomaticKeepAlives: true,
        physics: BouncingScrollPhysics(),
        pagingController: state.controller!,
        padding: EdgeInsets.only(top: 12, bottom: 12),
        builderDelegate: PagedChildBuilderDelegate<UserAdResponse>(
          firstPageErrorIndicatorBuilder: (_) {
            return SizedBox(
              height: 100,
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
                        text: Strings.loadingStateRetry.w(400).s(15))
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
            return UserAdEmptyWidget(
              onActionClicked: () {
                context.router.push(CreateAdStartRoute());
              },
            );
          },
          newPageProgressIndicatorBuilder: (_) {
            return SizedBox(
              height: 160,
              child: Center(
                child: CircularProgressIndicator(color: Colors.blue),
              ),
            );
          },
          newPageErrorIndicatorBuilder: (_) {
            return SizedBox(
              height: 160,
              child: Center(
                child: CircularProgressIndicator(color: Colors.blue),
              ),
            );
          },
          transitionDuration: Duration(milliseconds: 100),
          itemBuilder: (context, item, index) => UserAdWidget(
            onActionClicked: () async {
              // _showAdActions(context);

              final action = await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                backgroundColor: Colors.transparent,
                builder: (context) => AdListActionsPage(
                  key: Key(""),
                  userAdResponse: item,
                  userAdStatus: state.userAdStatus,
                ),
              );

              // cubit(context).getAdsController(status: )
            },
            onItemClicked: () {
              context.router.push(UserAdDetailRoute(userAdResponse: item));
            },
            response: item,
          ),
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/ad/user_ad.dart';
import 'package:onlinebozor/common/widgets/ad/user_ad_empty_widget.dart';
import 'package:onlinebozor/data/responses/user_ad/user_ad_response.dart';
import 'package:onlinebozor/presentation/home/features/profile/features/user_ads/features/active_ads/cubit/user_active_ads_cubit.dart';

import '../../../../../../../../common/core/base_page.dart';
import '../../../../../../../../common/gen/localization/strings.dart';
import '../../../../../../../../common/router/app_router.dart';
import '../../../../../../../../common/widgets/common/common_button.dart';

@RoutePage()
class UserActiveAdsPage extends BasePage<UserActiveAdsCubit,
    UserActiveAdsBuildable, UserActiveAdsListenable> {
  const UserActiveAdsPage({super.key});

  @override
  Widget builder(BuildContext context, UserActiveAdsBuildable state) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F4FB),
      body: PagedListView<int, UserAdResponse>(
        shrinkWrap: true,
        addAutomaticKeepAlives: true,
        physics: BouncingScrollPhysics(),
        pagingController: state.userAdsPagingController!,
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
                        child: Strings.loadingStateRetry.w(400).s(15))
                  ],
                ),
              ),
            );
          },
          firstPageProgressIndicatorBuilder: (_) {
            return SizedBox(
              height: 160,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ),
            );
          },
          noItemsFoundIndicatorBuilder: (_) {
            return UserAdEmptyWidget(listener: () {
              context.router.push(CreateAdStartRoute());
            });
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
            onActionClicked: () {},
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

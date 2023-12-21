import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/presentation/home/features/profile_dashboard/features/user_ads/features/inactive_ads/cubit/user_inactive_ads_cubit.dart';

import '../../../../../../../../common/gen/localization/strings.dart';
import '../../../../../../../../common/widgets/ad/user_ad.dart';
import '../../../../../../../../common/widgets/ad/user_ad_empty_widget.dart';
import '../../../../../../../../common/widgets/common/common_button.dart';
import '../../../../../../../../data/responses/user_ad/user_ad_response.dart';

@RoutePage()
class UserInactiveAdsPage extends BasePage<UserInactiveAdsCubit,
    UserInactiveAdsBuildable, UserInactiveAdsListenable> {
  const UserInactiveAdsPage({super.key});

  @override
  Widget builder(BuildContext context, UserInactiveAdsBuildable state) {
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: PagedGridView<int, UserAdResponse>(
        shrinkWrap: true,
        addAutomaticKeepAlives: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        pagingController: state.userAdsPagingController!,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: width / height,
            crossAxisSpacing: 16,
            mainAxisExtent: 185,
            crossAxisCount: 1,
            mainAxisSpacing: 0),
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
                        child: Strings.loadingStateRetrybutton.w(400).s(15))
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
            return UserAdEmptyWidget(listener: () {});
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
            listenerAddressEdit: () {},
            listener: () {},
            response: item,
          ),
        ),
      ),
    );
  }
}

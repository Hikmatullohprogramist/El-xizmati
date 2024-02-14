import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/presentation/home/features/profile/features/user_ads/features/cancel_ads/cubit/user_cancel_ads_cubit.dart';

import '../../../../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../../../../common/gen/localization/strings.dart';
import '../../../../../../../../common/router/app_router.dart';
import '../../../../../../../../common/vibrator/vibrator_extension.dart';
import '../../../../../../../../common/widgets/ad/user_ad.dart';
import '../../../../../../../../common/widgets/ad/user_ad_empty_widget.dart';
import '../../../../../../../../common/widgets/common/common_button.dart';
import '../../../../../../../../data/responses/user_ad/user_ad_response.dart';

@RoutePage()
class UserCancelAdsPage extends BasePage<UserCancelAdsCubit,
    UserCancelAdsBuildable, UserCancelAdsListenable> {
  const UserCancelAdsPage({super.key});

  @override
  Widget builder(BuildContext context, UserCancelAdsBuildable state) {
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
            onActionClicked: () {
              _showAdActions(context);
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

  void _showAdActions(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext buildContext) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Strings.actionTitle
                            .w(600)
                            .s(18)
                            .c(Color(0xFF41455E)),
                      ),
                      IconButton(
                        onPressed: () {
                          context.router.pop();
                          vibrateByTactile();
                        },
                        icon: Assets.images.icClose.svg(width: 24, height: 24),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  InkWell(
                    onTap: () {
                      context.router.pop();
                      vibrateByTactile();
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Assets.images.icEdit.svg(width: 24, height: 24),
                            SizedBox(width: 24),
                            Strings.editTitle.w(500).s(16).w(400)
                          ],
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      context.router.pop();
                      vibrateByTactile();
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Assets.images.icAdvertise
                                .svg(width: 24, height: 24),
                            SizedBox(width: 24),
                            Strings.advertiseTitle.s(16).w(400)
                          ],
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      context.router.pop();
                      vibrateByTactile();
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Assets.images.icDelete.svg(width: 24, height: 24),
                            SizedBox(width: 24),
                            Strings.deactivateTilte
                                .w(500)
                                .s(14)
                                .c(Color(0xFFFA6F5D))
                          ],
                        )),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          );
        });
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/common/widgets/loading/default_empty_widget.dart';
import 'package:onlinebozor/presentation/home/features/profile/features/user_orders/features/user_order_list/cubit/page_cubit.dart';

import '../../../../../../../../common/colors/static_colors.dart';
import '../../../../../../../../common/gen/localization/strings.dart';
import '../../../../../../../../common/widgets/order/user_order_shimmer.dart';
import '../../../../../../../../common/widgets/order/user_order_widget.dart';
import '../../../../../../../../data/responses/user_order/user_order_response.dart';
import '../../../../../../../../domain/models/ad/ad_transaction_type.dart';
import '../../../../../../../../domain/models/order/order_type.dart';
import '../../../../../../../../domain/models/order/user_order_status.dart';

@RoutePage()
class UserOrdersPage extends BasePage<PageCubit, PageState, PageEvent> {
  const UserOrdersPage({
    super.key,
    required this.type,
    required this.status,
  });

  final OrderType type;
  final UserOrderStatus status;

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(type, status);
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      backgroundColor: StaticColors.backgroundColor,
      body: _buildBody(context, state),
    );
  }

  Widget _buildBody(BuildContext context, PageState state) {
    return RefreshIndicator(
      displacement: 160,
      strokeWidth: 3,
      color: StaticColors.colorPrimary,
      onRefresh: () async {
        cubit(context).states.controller!.refresh();
      },
      child: PagedListView<int, UserOrder>(
        shrinkWrap: true,
        addAutomaticKeepAlives: false,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        pagingController: state.controller!,
        builderDelegate: PagedChildBuilderDelegate<UserOrder>(
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
                      onPressed: () {
                        cubit(context).states.controller?.refresh();
                      },
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
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return UserOrderWidgetShimmer();
                },
              ),
            );
          },
          noItemsFoundIndicatorBuilder: (_) {
            return DefaultEmptyWidget(
              isFullScreen: true,
              icon: Assets.images.pngImages.adEmpty.image(),
              message: Strings.adEmptyMessageActive,
              onMainActionClicked: () {
                if (type == OrderType.buy) {
                  context.router.push(CreateRequestAdRoute(
                    adTransactionType: AdTransactionType.BUY,
                  ));
                } else if (type == OrderType.sell) {
                  context.router.push(CreateRequestAdRoute(
                    adTransactionType: AdTransactionType.BUY_SERVICE,
                  ));
                }
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
          itemBuilder: (context, item, index) {
            return UserOrderWidget(
              order: item,
              onClicked: () {},
              onRemoveClicked: () {},
            );
          },
        ),
      ),
    );
  }
}

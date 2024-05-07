import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/core/colors/color_extension.dart';
import 'package:onlinebozor/core/colors/static_colors.dart';
import 'package:onlinebozor/core/cubit/base_page.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/data/datasource/network/responses/user_order/user_order_response.dart';
import 'package:onlinebozor/domain/models/order/order_type.dart';
import 'package:onlinebozor/domain/models/order/user_order_status.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_orders/features/user_order_cancel/user_order_cancel_page.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_orders/features/user_order_info/user_order_info_page.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/utils/resource_exts.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/loading/default_empty_widget.dart';
import 'package:onlinebozor/presentation/widgets/order/user_order_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/order/user_order_widget.dart';

import 'cubit/page_cubit.dart';

@RoutePage()
class UserOrderListPage extends BasePage<PageCubit, PageState, PageEvent> {
  const UserOrderListPage({
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
      backgroundColor: context.backgroundColor,
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
              message: state.userOrderStatus.getLocalizedEmptyMessage(),
              mainActionLabel: Strings.commonOpenMain,
              onMainActionClicked: () {
                context.router.replace(DashboardRoute());
              },
              onReloadClicked: () {
                cubit(context).states.controller?.refresh();
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
              onCancelClicked: () => _showOrderCancelPage(context, state, item),
              onMoreClicked: () => _showOrderInfoPage(context, state, item),
            );
          },
        ),
      ),
    );
  }

  Future<void> _showOrderCancelPage(
    BuildContext context,
    PageState state,
    UserOrder order,
  ) async {
    final cancelledOrder = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => UserOrderCancelPage(order: order),
    );

    cubit(context).updateCancelledOrder(cancelledOrder);
  }

  void _showOrderInfoPage(
    BuildContext context,
    PageState state,
    UserOrder order,
  ) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => UserOrderInfoPage(order: order),
    );
  }
}

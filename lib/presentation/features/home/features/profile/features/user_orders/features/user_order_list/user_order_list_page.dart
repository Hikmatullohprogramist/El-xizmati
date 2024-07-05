import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/data/datasource/network/responses/user_order/user_order_response.dart';
import 'package:onlinebozor/domain/models/order/order_type.dart';
import 'package:onlinebozor/domain/models/order/user_order_status.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_orders/features/user_order_info/user_order_info_page.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/extensions/resource_exts.dart';
import 'package:onlinebozor/presentation/widgets/elevation/elevation_widget.dart';
import 'package:onlinebozor/presentation/widgets/loading/default_empty_widget.dart';
import 'package:onlinebozor/presentation/widgets/loading/default_error_widget.dart';
import 'package:onlinebozor/presentation/widgets/order/user_order_shimmer.dart';
import 'package:onlinebozor/presentation/widgets/order/user_order_widget.dart';

import 'user_order_list_cubit.dart';

@RoutePage()
class UserOrderListPage extends BasePage<UserOrderListCubit, UserOrderListState,
    UserOrderListEvent> {
  final OrderType type;
  final UserOrderStatus status;

  const UserOrderListPage({
    super.key,
    required this.type,
    required this.status,
  });

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(type, status);
  }

  @override
  Widget onWidgetBuild(BuildContext context, UserOrderListState state) {
    return Scaffold(
      backgroundColor: context.backgroundGreyColor,
      body: _buildBody(context, state),
    );
  }

  Widget _buildBody(BuildContext context, UserOrderListState state) {
    return RefreshIndicator(
      displacement: 80,
      strokeWidth: 3,
      color: StaticColors.colorPrimary,
      onRefresh: () async {
        cubit(context).states.controller!.refresh();
      },
      child: PagedListView<int, UserOrder>(
        shrinkWrap: true,
        addAutomaticKeepAlives: false,
        // physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 10),
        pagingController: state.controller!,
        builderDelegate: PagedChildBuilderDelegate<UserOrder>(
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
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return UserOrderShimmer();
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
            return DefaultErrorWidget(
              isFullScreen: false,
              onRetryClicked: () => cubit(context).states.controller?.refresh(),
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
              child: UserOrderWidget(
                order: item,
                onClicked: () => _showOrderInfoPage(context, state, item),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showOrderInfoPage(
    BuildContext context,
    UserOrderListState state,
    UserOrder order,
  ) async {
    final cancelledOrder = await showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => UserOrderInfoPage(order: order),
    );

    if (cancelledOrder != null && cancelledOrder is UserOrder) {
      cubit(context).updateCancelledOrder(cancelledOrder);
    }
  }
}

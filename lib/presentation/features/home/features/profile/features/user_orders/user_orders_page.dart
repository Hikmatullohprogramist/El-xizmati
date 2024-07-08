import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/order/order_type.dart';
import 'package:onlinebozor/domain/models/order/user_order_status.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'user_orders_cubit.dart';

@RoutePage()
class UserOrdersPage
    extends BasePage<UserOrdersCubit, UserOrdersState, UserOrdersEvent> {
  final OrderType orderType;

  const UserOrdersPage(this.orderType, {super.key});

  @override
  void onWidgetCreated(BuildContext context) {
    Logger().w("onWidgetCreated orderType = $orderType");
    cubit(context).setInitialParams(orderType);
  }

  @override
  void onEventEmitted(BuildContext context, UserOrdersEvent event) {
    {
      switch (event.type) {
        case UserOrdersEventType.onOrderTypeChange:
          context.router.pop();
          Logger().w("onEventEmitted orderType = ${cubit(context).states.orderType}");
          context.router.replace(
            UserOrdersRoute(orderType: cubit(context).states.orderType),
          );
      }
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, UserOrdersState state) {

    return DefaultTabController(
      length: 2,
      initialIndex: orderType == OrderType.buy ? 1 : 0,
      child: Builder(
        builder: (context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              cubit(context).changeOrderType();
            }
          });
          return AutoTabsRouter.tabBar(
            physics: BouncingScrollPhysics(),
            routes: [
              UserOrderListRoute(
                type: state.orderType,
                status: UserOrderStatus.ALL,
              ),
              UserOrderListRoute(
                type: state.orderType,
                status: UserOrderStatus.WAIT,
              ),
              UserOrderListRoute(
                type: state.orderType,
                status: UserOrderStatus.REJECTED,
              ),
              UserOrderListRoute(
                type: state.orderType,
                status: UserOrderStatus.CANCELED,
              ),
              UserOrderListRoute(
                type: state.orderType,
                status: UserOrderStatus.IN_PROGRESS,
              ),
              UserOrderListRoute(
                type: state.orderType,
                status: UserOrderStatus.ACCEPTED,
              ),
            ],
            builder: (context, childPage, controller) {
              return Scaffold(
                backgroundColor: context.cardColor,
                appBar: _buildAppBar(context, controller),
                body: childPage,
              );
            },
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, TabController controller) {
    return AppBar(
      toolbarHeight: 120,
      backgroundColor: context.appBarColor,
      elevation: 0.5,
      // centerTitle: true,
      // title: Strings.orderListTitle.w(500).s(16)..c(context.textPrimary),
      leading: IconButton(
        onPressed: () => context.router.pop(),
        icon: Assets.images.icArrowLeft.svg(color: Colors.transparent),
      ),
      flexibleSpace: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 64,
                  height: 64,
                  child: InkWell(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      context.router.pop();
                    },
                    // borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Assets.images.icArrowLeft.svg(),
                    ),
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Strings.orderListTitle
                      .w(500)
                      .s(16)
                      .c(context.textPrimary)
                      .copyWith(textAlign: TextAlign.center),
                ),
                SizedBox(width: 64),
              ],
            ),
            SizedBox(height: 8),
            Container(
              margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
              height: 45,
              decoration: BoxDecoration(
                color: context.backgroundGreyColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: TabBar(
                padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                physics: BouncingScrollPhysics(),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: context.elevatedColor,
                ),
                labelColor: context.textPrimary,
                unselectedLabelColor: context.textSecondary,
                tabs: [
                  Tab(text: Strings.orderListTypeSell),
                  Tab(text: Strings.orderListTypeBuy)
                ],
              ),
            ),
          ],
        ),
      ),
      bottom: _buildTabBar(context, controller),
    );
  }

  TabBar _buildTabBar(BuildContext context, TabController controller) {
    return TabBar(
      isScrollable: true,
      physics: BouncingScrollPhysics(),
      indicator: MaterialIndicator(
        height: 6,
        tabPosition: TabPosition.bottom,
        topLeftRadius: 100,
        topRightRadius: 100,
        color: Color(0xFF5C6AC3),
        paintingStyle: PaintingStyle.fill,
      ),
      indicatorSize: TabBarIndicatorSize.label,
      labelColor: Color(0xFF5C6AC3),
      unselectedLabelColor: context.textSecondary,
      indicatorColor: context.textPrimary,
      controller: controller,
      tabs: [
        Tab(text: Strings.userOrderAll),
        Tab(text: Strings.userOrderWait),
        Tab(text: Strings.userOrderRejected),
        Tab(text: Strings.userOrderCancelled),
        Tab(text: Strings.userOrderInProgress),
        Tab(text: Strings.userOrderAccepted)
      ],
    );
  }
}

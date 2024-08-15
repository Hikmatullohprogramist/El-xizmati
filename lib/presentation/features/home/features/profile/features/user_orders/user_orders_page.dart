import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/order/order_type.dart';
import 'package:onlinebozor/domain/models/order/user_order_status.dart';
import 'package:onlinebozor/presentation/features/home/features/profile/features/user_orders/features/user_order_list/user_order_list_page.dart';
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
  Widget onWidgetBuild(BuildContext context, UserOrdersState state) {
    return DefaultTabController(
      length: 2,
      initialIndex: orderType == OrderType.buy ? 1 : 0,
      child: Builder(
        builder: (context) {
          final defaultTabController = DefaultTabController.of(context);
          defaultTabController.addListener(() {
            if (!defaultTabController.indexIsChanging) {
              cubit(context).changeOrderType();
            }
          });

          return _buildBodyWithTabBarView(context, state, defaultTabController);
        },
      ),
    );
  }

  Scaffold _buildBodyWithTabBarView(
    BuildContext context,
    UserOrdersState state,
    TabController defaultTabController,
  ) {
    return Scaffold(
      backgroundColor: context.cardColor,
      appBar: _buildTabBarViewAppBar(context, defaultTabController),
      body: TabBarView(
        physics: BouncingScrollPhysics(),
        children: [
          _buildTabViewContent(context, state, OrderType.sell),
          _buildTabViewContent(context, state, OrderType.buy),
        ],
      ),
    );
  }

  AppBar _buildTabBarViewAppBar(
    BuildContext context,
    TabController controller,
  ) {
    return AppBar(
      toolbarHeight: 116,
      backgroundColor: context.appBarColor,
      elevation: 0,
      leadingWidth: 0,
      leading: Assets.images.icArrowLeft.svg(color: Colors.transparent),
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
                    borderRadius: BorderRadius.circular(50),
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
            _buildOrderTypeTabBar(context, controller),
          ],
        ),
      ),
    );
  }

  Widget _buildTabViewContent(
    BuildContext context,
    UserOrdersState state,
    OrderType orderType,
  ) {
    const orderStatus = [
      UserOrderStatus.ALL,
      UserOrderStatus.WAIT,
      UserOrderStatus.REJECTED,
      UserOrderStatus.CANCELED,
      UserOrderStatus.IN_PROGRESS,
      UserOrderStatus.ACCEPTED,
    ];

    return DefaultTabController(
      length: 6,
      initialIndex: 0,
      child: Container(
        color: context.appBarColor,
        child: Column(
          children: [
            TabBar(
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
              // controller: controller,
              tabs: [
                Tab(text: Strings.userOrderAll),
                Tab(text: Strings.userOrderWait),
                Tab(text: Strings.userOrderRejected),
                Tab(text: Strings.userOrderCancelled),
                Tab(text: Strings.userOrderInProgress),
                Tab(text: Strings.userOrderAccepted)
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  for (var status in orderStatus)
                    UserOrderListPage(orderType: orderType, status: status),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// common methods

  Container _buildOrderTypeTabBar(
    BuildContext context,
    TabController controller,
  ) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
      height: 45,
      decoration: BoxDecoration(
        color: context.backgroundGreyColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TabBar(
        padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
        physics: BouncingScrollPhysics(),
        controller: controller,
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
    );
  }

  /// analogue variant

// Widget _buildBodyWithAutoTabsRouter(
//   UserOrdersState state,
//   TabController controller,
// ) {
//   return AutoTabsRouter.tabBar(
//     physics: BouncingScrollPhysics(),
//     routes: _getAutoTabsRoutes(state.orderType),
//     builder: (context, childPage, controller) {
//       return Scaffold(
//         backgroundColor: context.cardColor,
//         appBar: _buildAutoTabsRouterAppBar(context, controller),
//         body: childPage,
//       );
//     },
//   );
// }

// List<PageRouteInfo<dynamic>> _getAutoTabsRoutes(OrderType orderType) {
//   Logger().w("user-orders _getRoutesByOrderType orderType = $orderType");
//   return [
//     UserOrderListRoute(
//       type: orderType,
//       status: UserOrderStatus.ALL,
//     ),
//     UserOrderListRoute(
//       type: orderType,
//       status: UserOrderStatus.WAIT,
//     ),
//     UserOrderListRoute(
//       type: orderType,
//       status: UserOrderStatus.REJECTED,
//     ),
//     UserOrderListRoute(
//       type: orderType,
//       status: UserOrderStatus.CANCELED,
//     ),
//     UserOrderListRoute(
//       type: orderType,
//       status: UserOrderStatus.IN_PROGRESS,
//     ),
//     UserOrderListRoute(
//       type: orderType,
//       status: UserOrderStatus.ACCEPTED,
//     ),
//   ];
// }

// AppBar _buildAutoTabsRouterAppBar(
//   BuildContext context,
//   TabController controller,
// ) {
//   return AppBar(
//     toolbarHeight: 116,
//     backgroundColor: context.appBarColor,
//     elevation: 0.5,
//     leadingWidth: 0,
//     leading: Assets.images.icArrowLeft.svg(color: Colors.transparent),
//     flexibleSpace: SafeArea(
//       child: Column(
//         children: [
//           Row(
//             children: [
//               SizedBox(
//                 width: 64,
//                 height: 64,
//                 child: InkWell(
//                   onTap: () {
//                     HapticFeedback.lightImpact();
//                     context.router.pop();
//                   },
//                   borderRadius: BorderRadius.circular(50),
//                   child: Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Assets.images.icArrowLeft.svg(),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 4),
//               Expanded(
//                 child: Strings.orderListTitle
//                     .w(500)
//                     .s(16)
//                     .c(context.textPrimary)
//                     .copyWith(textAlign: TextAlign.center),
//               ),
//               SizedBox(width: 64),
//             ],
//           ),
//           SizedBox(height: 0),
//           _buildOrderTypeTabBar(context, controller),
//         ],
//       ),
//     ),
//     bottom: _buildAutoTabsRouterTabBar(context, controller),
//   );
// }

// TabBar _buildAutoTabsRouterTabBar(
//   BuildContext context,
//   TabController controller,
// ) {
//   return TabBar(
//     isScrollable: true,
//     physics: BouncingScrollPhysics(),
//     indicator: MaterialIndicator(
//       height: 6,
//       tabPosition: TabPosition.bottom,
//       topLeftRadius: 100,
//       topRightRadius: 100,
//       color: Color(0xFF5C6AC3),
//       paintingStyle: PaintingStyle.fill,
//     ),
//     indicatorSize: TabBarIndicatorSize.label,
//     labelColor: Color(0xFF5C6AC3),
//     unselectedLabelColor: context.textSecondary,
//     indicatorColor: context.textPrimary,
//     controller: controller,
//     tabs: [
//       Tab(text: Strings.userOrderAll),
//       Tab(text: Strings.userOrderWait),
//       Tab(text: Strings.userOrderRejected),
//       Tab(text: Strings.userOrderCancelled),
//       Tab(text: Strings.userOrderInProgress),
//       Tab(text: Strings.userOrderAccepted)
//     ],
//   );
// }
}

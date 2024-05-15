import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/colors/color_extension.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/order/order_type.dart';
import 'package:onlinebozor/domain/models/order/user_order_status.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_text_button.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import 'cubit/user_orders_cubit.dart';

@RoutePage()
class UserOrdersPage extends BasePage<PageCubit, PageState, PageEvent> {
  const UserOrdersPage(this.orderType, {super.key});

  final OrderType orderType;

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(orderType);
  }

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    {
      switch (event.type) {
        case PageEventType.onOrderTypeChange:
          context.router.pop();
          context.router.push(
            UserOrdersRoute(orderType: cubit(context).states.orderType),
          );
      }
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
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
      builder: (context, child, controller) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              CustomTextButton(
                text: state.orderType == OrderType.sell
                    ? Strings.orderListTypeSell
                    : Strings.orderListTypeBuy,
                onPressed: () {
                  cubit(context).changeOrderType();
                },
              )
            ],
            leading: IconButton(
              icon: Assets.images.icArrowLeft.svg(),
              onPressed: () => context.router.pop(),
            ),
            elevation: 0.5,
            backgroundColor: context.backgroundColor,
            centerTitle: true,
            bottomOpacity: 1,
            title: Strings.orderListTitle
                .w(500)
                .s(16)
                .c(context.colors.textPrimary),
            bottom: TabBar(
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
              unselectedLabelColor: Color(0xFF9EABBE),
              indicatorColor: context.colors.textPrimary,
              controller: controller,
              tabs: [
                Tab(text: Strings.userOrderAll),
                Tab(text: Strings.userOrderWait),
                Tab(text: Strings.userOrderRejected),
                Tab(text: Strings.userOrderCancelled),
                Tab(text: Strings.userOrderInProgress),
                Tab(text: Strings.userOrderAccepted)
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}

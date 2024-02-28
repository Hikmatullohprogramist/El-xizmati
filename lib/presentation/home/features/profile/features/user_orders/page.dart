import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/presentation/home/features/profile/features/user_orders/cubit/page_cubit.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../../../../../common/core/base_page.dart';
import '../../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../../common/widgets/common/common_button.dart';
import '../../../../../../domain/models/order/order_type.dart';
import '../../../../../../domain/models/order/user_order_status.dart';
import 'features/user_order_list/page.dart';

@RoutePage()
class UserOrdersPage extends BasePage<PageCubit,
    PageState,
    PageEvent> {
  const UserOrdersPage(this.orderType, {super.key});

  final OrderType orderType;

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return AutoTabsRouter.tabBar(
      physics: BouncingScrollPhysics(),
      routes: [
        UserOrderListPage(type: orderType, status: UserOrderStatus.all),
        UserOrderListPage(type: orderType, status: UserOrderStatus.accept),
        UserOrderListPage(type: orderType, status: UserOrderStatus.active),
        UserOrderListPage(type: orderType, status: UserOrderStatus.review),
        UserOrderListPage(type: orderType, status: UserOrderStatus.rejected),
        UserOrderListPage(type: orderType, status: UserOrderStatus.canceled),
      ],
      builder: (context, child, controller) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              CommonButton(
                  type: ButtonType.text,
                  onPressed: () {
                    if (orderType == OrderType.buy) {
                      context.router.push(CreateProductOrderRoute());
                    } else if (orderType == OrderType.sell) {
                      context.router.push(CreateServiceOrderRoute());
                    }
                  },
                  child: Strings.createRequestTitle
                      .w(500)
                      .s(12)
                      .c(Color(0xFF5C6AC3)))
            ],
            leading: IconButton(
              icon: Assets.images.icArrowLeft.svg(),
              onPressed: () => context.router.pop(),
            ),
            elevation: 0.5,
            backgroundColor: Colors.white,
            centerTitle: true,
            bottomOpacity: 1,
            title: Strings.myRequestsTitle
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
                Tab(text: Strings.userRequestAllTitle),
                Tab(text: Strings.userRequestPendingTitle),
                Tab(text: Strings.userRequestRejactionTitle),
                Tab(text: Strings.userRequestCanceledTitle),
                Tab(text: Strings.userRequestReviewTitle),
                Tab(text: Strings.userRequestAcceptTitle)
              ],
            ),
          ),
          body: child,
        );
      },
    );
  }
}

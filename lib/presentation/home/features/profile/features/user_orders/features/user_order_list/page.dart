import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/presentation/home/features/profile/features/user_orders/features/user_order_list/cubit/page_cubit.dart';

import '../../../../../../../../common/gen/localization/strings.dart';
import '../../../../../../../../common/router/app_router.dart';
import '../../../../../../../../common/widgets/ad/user_ad_empty_widget.dart';
import '../../../../../../../../common/widgets/common/common_button.dart';
import '../../../../../../../../common/widgets/order/user_order.dart';
import '../../../../../../../../data/responses/user_order/user_order_response.dart';
import '../../../../../../../../domain/models/order/order_type.dart';
import '../../../../../../../../domain/models/order/user_order_status.dart';

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
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFF2F4FB),
      body: _getOrderListWidget(context, state, width, height),
    );
  }

  Widget _getOrderListWidget(
    BuildContext context,
    PageState state,
    double width,
    double height,
  ) {
    return PagedGridView<int, UserOrderResponse>(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 12),
      addAutomaticKeepAlives: true,
      physics: BouncingScrollPhysics(),
      pagingController: state.controller!,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: width / height,
        crossAxisSpacing: 16,
        mainAxisExtent: 165,
        crossAxisCount: 1,
        mainAxisSpacing: 0,
      ),
      builderDelegate: PagedChildBuilderDelegate<UserOrderResponse>(
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
              child: CircularProgressIndicator(color: Colors.blue),
            ),
          );
        },
        noItemsFoundIndicatorBuilder: (_) {
          return UserAdEmptyWidget(listener: () {
            if (type == OrderType.buy) {
              context.router.push(CreateProductOrderRoute());
            } else if (type == OrderType.sell) {
              context.router.push(CreateServiceOrderRoute());
            }
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
        itemBuilder: (context, item, index) {
          return UserOrderWidget(
            listenerAddressEdit: () {},
            listener: () {},
            response: item,
          );
        },
      ),
    );
  }
}

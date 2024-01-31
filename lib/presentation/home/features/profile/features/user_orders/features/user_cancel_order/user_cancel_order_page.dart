import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/presentation/home/features/profile/features/user_orders/features/user_cancel_order/cubit/user_cancel_order_cubit.dart';

import '../../../../../../../../common/gen/localization/strings.dart';
import '../../../../../../../../common/router/app_router.dart';
import '../../../../../../../../common/widgets/ad/user_ad_empty_widget.dart';
import '../../../../../../../../common/widgets/common/common_button.dart';
import '../../../../../../../../common/widgets/order/user_order.dart';
import '../../../../../../../../data/responses/user_order/user_order_response.dart';
import '../../../../../../../../domain/models/order/order_type.dart';

@RoutePage()
class UserCancelOrderPage extends BasePage<UserCancelOrderCubit,
    UserCancelOrderBuildable, UserCancelOrderListenable> {
  const UserCancelOrderPage(this.orderType, {super.key});

  final OrderType orderType;

  @override
  void init(BuildContext context) {
    context.read<UserCancelOrderCubit>().setInitialOrderType(orderType);
  }

  @override
  Widget builder(BuildContext context, UserCancelOrderBuildable state) {
    double width;
    double height;
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFF2F4FB),
      body: PagedGridView<int, UserOrderResponse>(
        shrinkWrap: true,
        addAutomaticKeepAlives: true,
        physics: BouncingScrollPhysics(),
        pagingController: state.userOrderPagingController!,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: width / height,
            crossAxisSpacing: 16,
            mainAxisExtent: 185,
            crossAxisCount: 1,
            mainAxisSpacing: 0),
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
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
              );
            },
            noItemsFoundIndicatorBuilder: (_) {
              return UserAdEmptyWidget(listener: () {
                context.router.push(OrderCreationRoute());
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
                  listenerAddressEdit: () {}, listener: () {}, response: item);
            }),
      ),
    );
  }
}

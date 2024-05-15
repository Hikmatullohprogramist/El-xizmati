import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/colors/color_extension.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/domain/models/order/order_type.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/default_app_bar.dart';

import 'cubit/user_order_type_cubit.dart';

@RoutePage()
class UserOrderTypePage extends BasePage<PageCubit, PageState, PageEvent> {
  const UserOrderTypePage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: DefaultAppBar(
        titleText: "",
        backgroundColor: context.backgroundColor,
        onBackPressed: () => context.router.pop(),
      ),
      backgroundColor: context.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCreateProductRequest(context),
            SizedBox(height: 16),
            _buildCreateServiceRequest(context)
          ],
        ),
      ),
    );
  }

  Widget _buildCreateProductRequest(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.router.push(UserOrdersRoute(orderType: OrderType.buy));
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Color(0xFFE5E9F3), width: 1),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Assets.images.pngImages.sell.image(width: 116, height: 116),
                    SizedBox(height: 16),
                    "Sotaman".w(500).s(16).c(context.colors.textPrimary)
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreateServiceRequest(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.router.push(UserOrdersRoute(orderType: OrderType.sell));
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Color(0xFFE5E9F3), width: 1),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Assets.images.pngImages.buy.image(width: 116, height: 116),
                    SizedBox(height: 16),
                    "Sotib olaman".w(500).s(16).c(context.colors.textPrimary)
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

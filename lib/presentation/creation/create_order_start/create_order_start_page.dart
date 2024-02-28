import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/router/app_router.dart';

import '../../../../../../common/gen/assets/assets.gen.dart';
import 'cubit/create_order_start_cubit.dart';

@RoutePage()
class CreateOrderStartPage extends BasePage<PageCubit, PageState, PageEvent> {
  const CreateOrderStartPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () => context.router.pop(),
        ),
      ),
      backgroundColor: Color(0xFFF2F4FB),
      body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCreateProductRequest(context),
            _buildCreateServiceRequest(context)
          ]),
    );
  }

  Widget _buildCreateProductRequest(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          context.router.push(CreateProductOrderRoute());
        },
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
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
    );
  }

  Widget _buildCreateServiceRequest(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          context.router.push(CreateServiceOrderRoute());
        },
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Color(0xFFE5E9F3), width: 1)),
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
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/domain/models/ad/ad_transaction_type.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/colors/color_extension.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';

import 'cubit/create_request_start_cubit.dart';

@RoutePage()
class CreateRequestStartPage extends BasePage<PageCubit, PageState, PageEvent> {
  const CreateRequestStartPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.appBarColor,
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () => context.router.pop(),
        ),
      ),
      backgroundColor: context.backgroundColor,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCreateProductRequest(context),
          _buildCreateServiceRequest(context)
        ],
      ),
    );
  }

  Widget _buildCreateProductRequest(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          context.router.push(CreateRequestAdRoute(
            adTransactionType: AdTransactionType.BUY,
          ));
        },
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 8),
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: context.cardStrokeColor, width: 1),
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
          context.router.push(CreateRequestAdRoute(
            adTransactionType: AdTransactionType.BUY_SERVICE,
          ));
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

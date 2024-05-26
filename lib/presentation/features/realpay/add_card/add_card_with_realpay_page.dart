import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_constants.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/widgets/webview/oauth_web_view.dart';

import 'cubit/add_card_with_realpay_cubit.dart';

@RoutePage()
class AddCardWithRealPayPage extends BasePage<PageCubit, PageState, PageEvent> {
  const AddCardWithRealPayPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return SizedBox(
      width: double.infinity,
      // height: MediaQuery.sizeOf(context).height * .9,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Container(
          color: context.bottomSheetColor,
          padding: EdgeInsets.only(top: 15),
          child: Stack(
            children: [
              state.loadingState == LoadingState.loading
                  ? Center(
                      child: CircularProgressIndicator(
                      color: StaticColors.dodgerBlue,
                    ))
                  : OAuthWebView(
                      initialUrl: cubit(context).generatePaymentUrl(),
                      redirectUrl: RestConstants.REAL_PAY_REDIRECT_URI,
                      onPageStarted: (url) {},
                      onProcess: (process) {},
                      onPageFinished: (url) {},
                      onRedirectUrlHandled: (url) {
                        cubit(context).stateMessageManager.showSuccessSnackBar(
                            "Тўлов муаффиқиятли қабул қилинди");
                        context.router.pop();
                      },
                      onFailed: (url) {},
                    ),
              InkWell(
                onTap: () {
                  context.router.pop();
                },
                child: Container(
                  alignment: Alignment.topRight,
                  height: 40,
                  width: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Assets.images.icClose.svg(color: Colors.red),
                      SizedBox(width: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

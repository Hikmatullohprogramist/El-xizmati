import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_constants.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:onlinebozor/presentation/widgets/webview/oauth_web_view.dart';

import 'refill_with_realpay_cubit.dart';

@RoutePage()
class RefillWithRealPayPage extends BasePage<RefillWithRealpayCubit,
    RefillWithRealpayState, RefillWithRealpayEvent> {
  const RefillWithRealPayPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, RefillWithRealpayState state) {
    return Material(
      child: SizedBox(
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
                    : Column(
                        children: [
                          SizedBox(height: 24),
                          Expanded(
                            child: OAuthWebView(
                              initialUrl: cubit(context).generatePaymentUrl(),
                              redirectUrl: RestConstants.REAL_PAY_REDIRECT_URI,
                              onPageStarted: (url) {},
                              onProcess: (process) {},
                              onPageFinished: (url) {},
                              onRedirectUrlHandled: (url) {
                                cubit(context)
                                    .stateMessageManager
                                    .showSuccessSnackBar(
                                        Strings.depositRefillSuccessMessage);
      
                                context.router.pop(true);
                              },
                              onFailed: (url) {},
                            ),
                          ),
                        ],
                      ),
                BottomSheetTitle(
                  title: Strings.depositRefillTitle,
                  onCloseClicked: () {
                    context.router.pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

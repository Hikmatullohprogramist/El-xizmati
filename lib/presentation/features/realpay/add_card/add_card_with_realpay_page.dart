import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:El_xizmati/core/enum/enums.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/data/datasource/network/constants/rest_constants.dart';
import 'package:El_xizmati/presentation/support/colors/static_colors.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/widgets/bottom_sheet/bottom_sheet_title.dart';
import 'package:El_xizmati/presentation/widgets/webview/oauth_web_view.dart';

import 'add_card_with_realpay_cubit.dart';

@RoutePage()
class AddCardWithRealPayPage extends BasePage<AddCardWithRealpayCubit,
    AddCardWithRealpayState, AddCardWithRealpayEvent> {
  const AddCardWithRealPayPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, AddCardWithRealpayState state) {
    return Material(
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
                            onRedirectUrlHandled: (url) async {
                              cubit(context)
                                  .stateMessageManager
                                  .showSuccessSnackBar(
                                      Strings.cardAddedMessage);

                              await Future.delayed(Duration(seconds: 2));

                              context.router.pop(true);
                            },
                            onFailed: (url) {},
                          ),
                        ),
                      ],
                    ),
              BottomSheetTitle(
                title: Strings.cardAddTitle,
                onCloseClicked: () {
                  context.router.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

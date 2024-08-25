import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:El_xizmati/data/datasource/network/constants/rest_constants.dart';
import 'package:El_xizmati/presentation/router/app_router.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';
import 'package:El_xizmati/presentation/support/cubit/base_page.dart';
import 'package:El_xizmati/presentation/widgets/webview/oauth_web_view.dart';

import 'one_id_cubit.dart';

@RoutePage()
class OneIdPage extends BasePage<OneIdCubit, OneIdState, OneIdEvent> {
  const OneIdPage({super.key});

  @override
  void onEventEmitted(BuildContext context, OneIdEvent event) {
    switch (event.effect) {
      case OneIdEventType.onStartPageLoading:
        break;
      case OneIdEventType.onSuccessLogin:
        context.router.replace(HomeRoute());
        break;
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, OneIdState state) {
    return Scaffold(
      backgroundColor: context.backgroundWhiteColor,
      appBar: AppBar(
        backgroundColor: context.appBarColor,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: context.colors.iconSecondary,
            ),
            onPressed: () => context.router.pop()),
      ),
      body: Stack(
        children: [
          OAuthWebView(
            initialUrl: _buildOAuthUrl(),
            redirectUrl: RestConstants.ONE_ID_REDIRECT_URI,
            onPageStarted: (url) => cubit(context).onPageStarted(),
            onProcess: (process) => cubit(context).onProcess(),
            onPageFinished: (url) => cubit(context).onPageFinished(),
            onFailed: (error) => cubit(context).onPageFailed(),
            onRedirectUrlHandled: (url) => cubit(context).loginWithOneId(url),
          ),
          state.isPageLoadingInProgress
              ? Center(child: CircularProgressIndicator())
              : Center()
        ],
      ),
    );
  }

  String _buildOAuthUrl() {
    var uri = Uri.parse(RestConstants.ONE_ID_BASE_URL);
    var params = {
      'response_type': 'one_code',
      'client_id': 'hujjat_uz',
      'redirect_uri': RestConstants.ONE_ID_REDIRECT_URI,
      'scope': 'hujjat_uz',
      'state': 'active'
    };
    return uri.replace(queryParameters: params).toString();
  }
}

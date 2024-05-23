import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_constants.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/colors/color_extension.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/widgets/webview/oauth_web_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'cubit/auth_with_one_id_cubit.dart';

@RoutePage()
class AuthWithOneIdPage extends BasePage<PageCubit, PageState, PageEvent> {
  AuthWithOneIdPage({super.key});

  WebViewController? _webViewController = null;

  @override
  bool get wantKeepAlive => true;

  @override
  void onWidgetCreated(BuildContext context) {
    // cubit(context).setInitialParams();
  }

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.effect) {
      case PageEventType.onStartPageLoading:
        break;
      case PageEventType.onSuccessLogin:
        context.router.replace(HomeRoute());
        break;
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.backgroundColor,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: context.colors.iconGrey,
            ),
            onPressed: () => context.router.pop()),
      ),
      body: Stack(
        children: [
          OAuthWebView(
            initialUrl: _buildOAuthUrl(),
            redirectUrl: RestConstants.ONE_ID_FALLBACK,
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
      'redirect_uri': RestConstants.ONE_ID_FALLBACK,
      'scope': 'hujjat_uz',
      'state': 'active'
    };
    return uri.replace(queryParameters: params).toString();
  }
}

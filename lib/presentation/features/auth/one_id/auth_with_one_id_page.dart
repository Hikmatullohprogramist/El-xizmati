import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/core/colors/color_extension.dart';
import 'package:onlinebozor/core/cubit/base_page.dart';
import 'package:onlinebozor/data/datasource/network/constants/rest_constants.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'cubit/page_cubit.dart';

@RoutePage()
class AuthWithOneIdPage extends BasePage<PageCubit, PageState, PageEvent> {
  const AuthWithOneIdPage({super.key});

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.effect) {
      case PageEventType.onSuccessLogin:
        context.router.replace(HomeRoute());
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
          WebViewWidget(
            controller: WebViewController()
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setBackgroundColor(const Color(0x00000000))
              ..clearCache()
              ..clearLocalStorage()
              ..setNavigationDelegate(
                NavigationDelegate(
                  onProgress: (int progress) {
                    cubit(context).hideLoading();
                  },
                  onPageStarted: (String url) {
                    cubit(context).hideLoading();
                    CircularProgressIndicator(
                      color: Colors.blueAccent,
                    );
                  },
                  onPageFinished: (String url) {},
                  onWebResourceError: (WebResourceError error) {},
                  onNavigationRequest: (NavigationRequest request) {
                    if (request.url.startsWith(RestConstants.ONE_ID_FALLBACK)) {
                      cubit(context).loginWithOneId(request.url);
                      return NavigationDecision.prevent;
                    } else {
                      return NavigationDecision.navigate;
                    }
                  },
                ),
              )
              ..loadRequest(
                Uri.parse(
                    "https://sso.egov.uz/sso/oauth/Authorization.do?response_type=one_code&client_id=hujjat_uz&redirect_uri=${RestConstants.ONE_ID_FALLBACK}&scope=hujjat_uz&state=active"),
              ),
          ),
          state.isLoading
              ? Center(child: CircularProgressIndicator())
              : Center()
        ],
      ),
    );
  }
}

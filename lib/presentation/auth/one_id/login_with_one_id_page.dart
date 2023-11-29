import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/presentation/auth/one_id/cubit/login_with_one_id_cubit.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../common/core/base_page.dart';
import '../../../common/router/app_router.dart';

@RoutePage()
class LoginWithOneIdPage extends BasePage<LoginWithOneIdCubit,
    LoginWithOneIdBuildable, LoginWithOneIdListenable> {
  const LoginWithOneIdPage({super.key});

  @override
  void listener(BuildContext context, LoginWithOneIdListenable state) {
    switch (state.effect) {
      case LoginWithOneIdEffect.navigationHome:
        context.router.replace(HomeRoute());
    }
  }

  @override
  Widget builder(BuildContext context, LoginWithOneIdBuildable state) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
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
                      context.read<LoginWithOneIdCubit>().hideLoading();
                    },
                    onPageStarted: (String url) {
                      context.read<LoginWithOneIdCubit>().hideLoading();
                      CircularProgressIndicator(
                        color: Colors.blueAccent,
                      );
                    },
                    onPageFinished: (String url) {},
                    onWebResourceError: (WebResourceError error) {},
                    onNavigationRequest: (NavigationRequest request) {
                      if (request.url.startsWith(
                          'https://cabinet.smartoffice.realsoft.uz/oneid/android/fallback?')) {
                        context
                            .read<LoginWithOneIdCubit>()
                            .loginWithOneId(request.url);
                        return NavigationDecision.prevent;
                      } else {
                        return NavigationDecision.navigate;
                      }
                    },
                  ),
                )
                ..loadRequest(
                  Uri.parse(
                      "https://sso.egov.uz/sso/oauth/Authorization.do?response_type=one_code&client_id=hujjat_uz&redirect_uri=https://cabinet.smartoffice.realsoft.uz/oneid/android/fallback&scope=hujjat_uz&state=active"),
                ),
            ),
            state.isLoading
                ? Center(child: CircularProgressIndicator())
                : Center()
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OAuthWebView extends StatefulWidget {
  final String initialUrl;
  final String redirectUrl;
  final Function(int) onProcess;
  final Function(String) onPageStarted;
  final Function(String) onPageFinished;
  final Function(String) onRedirectUrlHandled;
  final Function(WebResourceError) onFailed;

  const OAuthWebView({
    super.key,
    required this.initialUrl,
    required this.redirectUrl,
    required this.onPageStarted,
    required this.onProcess,
    required this.onPageFinished,
    required this.onRedirectUrlHandled,
    required this.onFailed,
  });

  @override
  State<OAuthWebView> createState() => _OAuthWebViewState();
}

class _OAuthWebViewState extends State<OAuthWebView>
    with AutomaticKeepAliveClientMixin {
  late final WebViewController _webViewController;

  @override
  bool get wantKeepAlive => true;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);

    _webViewController = WebViewController()
      ..clearCache()
      ..clearLocalStorage()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..loadRequest(Uri.parse(widget.initialUrl))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (progress) => widget.onProcess(progress),
          onPageStarted: (url) => widget.onPageStarted(url),
          onPageFinished: (url) => widget.onPageFinished(url),
          onWebResourceError: (error) => widget.onFailed(error),
          onNavigationRequest: (request) {
            Logger().w("onNavigationRequest request  = $request");
            if (request.url.startsWith(widget.redirectUrl)) {
              widget.onRedirectUrlHandled(request.url);
              return NavigationDecision.prevent;
            } else {
              return NavigationDecision.navigate;
            }
          },
        ),
      );
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WebViewWidget(
      key: const PageStorageKey('oauth_web_view_key'),
      controller: _webViewController,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/enum/enums.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/common_button.dart';

class LoaderStateWidget extends StatelessWidget {
  const LoaderStateWidget(
      {super.key,
      required this.isFullScreen,
      required this.loadingState,
      required this.child,
      this.onErrorToAgainRequest,
      this.onStartWidget,
      this.onEmptyWidget});

  final bool isFullScreen;
  final AppLoadingState loadingState;
  final Widget child;
  final Widget? onStartWidget;
  final Widget? onEmptyWidget;
  final VoidCallback? onErrorToAgainRequest;

  @override
  Widget build(BuildContext context) {
    return switch (loadingState) {
      AppLoadingState.loading => LoadingWidget(isFullScreen: isFullScreen),
      AppLoadingState.error => ErrorWidget(isFullScreen: isFullScreen),
      AppLoadingState.success => child,
      AppLoadingState.onStart => onStartWidget ?? Center(),
      AppLoadingState.empty => onEmptyWidget ?? Center(),
    };
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, required this.isFullScreen});

  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    return isFullScreen
        ? Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          )
        : SizedBox(
            height: 160,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget(
      {super.key, required this.isFullScreen, this.onErrorToAgainRequest});

  final bool isFullScreen;
  final VoidCallback? onErrorToAgainRequest;

  @override
  Widget build(BuildContext context) {
    return isFullScreen
        ? Center(
            child: Column(
            children: [
              "Xatolik yuz berdi?".w(400).s(14).c(context.colors.textPrimary),
              SizedBox(height: 12),
              CommonButton(
                  onPressed: onErrorToAgainRequest,
                  type: ButtonType.elevated,
                  child: "Qayta urinish".w(400).s(15))
            ],
          ))
        : Center(
            child: SizedBox(
              height: 160,
              child: Column(children: [
                "Xatolik yuz berdi?".w(400).s(14).c(context.colors.textPrimary),
                SizedBox(height: 12),
                CommonButton(
                    onPressed: onErrorToAgainRequest,
                    type: ButtonType.elevated,
                    child: "Qayta urinish".w(400).s(15))
            ]),
            ),
          );
  }
}

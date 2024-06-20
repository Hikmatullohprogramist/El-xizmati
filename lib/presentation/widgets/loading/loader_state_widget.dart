import 'package:flutter/material.dart';
import 'package:onlinebozor/core/enum/enums.dart';
import 'package:onlinebozor/presentation/widgets/loading/default_empty_widget.dart';
import 'package:onlinebozor/presentation/widgets/loading/default_error_widget.dart';

class LoaderStateWidget extends StatelessWidget {
  const LoaderStateWidget({
    super.key,
    required this.loadingState,
    this.initialBody,
    this.loadingBody,
    required this.successBody,
    this.emptyBody,
    this.errorBody,
    this.onRetryClicked,
    this.onReloadClicked,
    this.isFullScreen = false,
  });

  final bool isFullScreen;
  final LoadingState loadingState;
  final Widget successBody;
  final Widget? initialBody;
  final Widget? loadingBody;
  final Widget? emptyBody;
  final Widget? errorBody;
  final VoidCallback? onRetryClicked;
  final VoidCallback? onReloadClicked;

  @override
  Widget build(BuildContext context) {
    return switch (loadingState) {
      LoadingState.initial => initialBody ?? _buildDefaultInitialBody(),
      LoadingState.loading => loadingBody ?? _buildDefaultLoadingBody(),
      LoadingState.success => successBody,
      LoadingState.empty => emptyBody ?? _buildDefaultEmptyBody(),
      LoadingState.error => errorBody ?? _buildDefaultErrorBody(),
    };
  }

  Widget _buildDefaultInitialBody() {
    return Center();
  }

  Widget _buildDefaultLoadingBody() {
    return DefaultErrorWidget(isFullScreen: isFullScreen);
  }

  Widget _buildDefaultEmptyBody() {
    return DefaultEmptyWidget(
      isFullScreen: isFullScreen,
      onMainActionClicked: onReloadClicked,
    );
  }

  Widget _buildDefaultErrorBody() {
    return DefaultErrorWidget(
      isFullScreen: isFullScreen,
      onRetryClicked: onRetryClicked,
    );
  }
}

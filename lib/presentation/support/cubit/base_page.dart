import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/support/vibrator/vibrator_extension.dart';
import 'package:onlinebozor/presentation/di/injection.dart';
import 'package:onlinebozor/presentation/support/colors/color_extension.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/presentation/support/cubit/base_builder.dart';
import 'package:onlinebozor/presentation/support/cubit/base_event.dart';
import 'package:onlinebozor/presentation/support/cubit/base_state.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';

abstract class BasePage<CUBIT extends Cubit<BaseState<STATE, EVENT>>, STATE,
    EVENT> extends StatelessWidget {
  const BasePage({Key? key}) : super(key: key);

  void onWidgetCreated(BuildContext context) {}

  void onEventEmitted(BuildContext context, EVENT event) {}

  Widget onWidgetBuild(BuildContext context, STATE state);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CUBIT>(
      create: (_) => getIt<CUBIT>(),
      child: Builder(
        builder: (context) {
          onWidgetCreated(context);

          return BaseListener<CUBIT, STATE, EVENT>(
            onEventEmitted: (event) => onEventEmitted(context, event),
            widget:
                BaseBuilder<CUBIT, STATE, EVENT>(onWidgetBuild: onWidgetBuild),
          );
        },
      ),
    );
  }

  CUBIT cubit(BuildContext context) {
    return context.read<CUBIT>();
  }

  // STATE state(BuildContext context) {
  //   return context.read<STATE>();
  // }

  EVENT event(BuildContext context) {
    return context.read<EVENT>();
  }

  void showExitAlertDialog(BuildContext context) {
    TextButton negativeButton = TextButton(
      child: Text(Strings.commonNo),
      onPressed: () {
        context.router.pop(context);
      },
    );

    TextButton positiveButton = TextButton(
      child: Text(Strings.commonYes),
      onPressed: () {
        context.router.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Alert Title"),
      content: Text("This is the alert message."),
      actions: [negativeButton, positiveButton],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showProgressDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      useRootNavigator: false,
      useSafeArea: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: true,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircularProgressIndicator(color: StaticColors.dodgerBlue),
              ],
            ),
          ),
        );
      },
    );
  }

  void showErrorBottomSheet(BuildContext context, String message) =>
      _showStateBottomSheet(context, Strings.messageTitleError, message);

  void showInfoBottomSheet(BuildContext context, String message) =>
      _showStateBottomSheet(context, Strings.messageTitleInfo, message);

  void showSuccessBottomSheet(BuildContext context, String message) =>
      _showStateBottomSheet(context, Strings.messageTitleSuccess, message);

  void showWarningBottomSheet(BuildContext context, String message) =>
      _showStateBottomSheet(context, Strings.messageTitleWarning, message);

  void _showStateBottomSheet(
    BuildContext context,
    String title,
    String message,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          decoration: BoxDecoration(
            color: context.bottomSheetColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30),
              Center(child: title.s(22).w(600)),
              SizedBox(height: 14),
              message.s(16).w(500).copyWith(
                    maxLines: 5,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
              SizedBox(height: 32),
              CustomElevatedButton(
                text: Strings.closeTitle,
                onPressed: () {
                  Navigator.pop(context);
                  vibrateAsHapticFeedback();
                },
                backgroundColor: context.colors.buttonPrimary,
              ),
              SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}

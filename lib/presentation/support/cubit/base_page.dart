import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/application/di/get_it_injection.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/presentation/support/cubit/base_builder.dart';
import 'package:onlinebozor/presentation/support/cubit/base_event.dart';
import 'package:onlinebozor/presentation/support/cubit/base_state.dart';
import 'package:onlinebozor/presentation/support/extensions/platform_sizes.dart';
import 'package:onlinebozor/presentation/support/state_message/state_bottom_sheet_exts.dart';
import 'package:onlinebozor/presentation/support/state_message/state_message_type.dart';
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
            child: CircularProgressIndicator(color: StaticColors.dodgerBlue),
          ),
        );
      },
    );
  }

  void hideProgressBarDialog(BuildContext context) {
    // Navigator.of(context, rootNavigator: true).pop();
    context.router.pop();
  }

  void showErrorBottomSheet(BuildContext context, String message) =>
      context.showStateBottomSheet(
        Strings.messageTitleError,
        message,
        MessageType.error,
      );

  void showInfoBottomSheet(BuildContext context, String message) =>
      context.showStateBottomSheet(
        Strings.messageTitleInfo,
        message,
        MessageType.info,
      );

  void showSuccessBottomSheet(BuildContext context, String message) =>
      context.showStateBottomSheet(
        Strings.messageTitleSuccess,
        message,
        MessageType.success,
      );

  void showWarningBottomSheet(BuildContext context, String message) =>
      context.showStateBottomSheet(
        Strings.messageTitleWarning,
        message,
        MessageType.warning,
      );

  void showYesNoBottomSheet(
    BuildContext context, {
    required String title,
    required String message,
    required String yesTitle,
    required Function onYesClicked,
    required String noTitle,
    required Function onNoClicked,
  }) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => Material(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 24),
            Center(child: title.s(18)),
            SizedBox(height: 24),
            Center(child: message.s(16).copyWith(textAlign: TextAlign.center)),
            SizedBox(height: 32),
            Row(
              children: <Widget>[
                SizedBox(width: 16),
                Expanded(
                  child: CustomElevatedButton(
                    text: noTitle,
                    onPressed: () {
                      onNoClicked();
                      Navigator.pop(context);
                      HapticFeedback.lightImpact();
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CustomElevatedButton(
                    text: yesTitle,
                    onPressed: () {
                      onYesClicked();
                      Navigator.pop(context);
                      HapticFeedback.lightImpact();
                    },
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
            SizedBox(height: bottomSheetBottomPadding),
          ],
        ),
      ),
    );
  }
}

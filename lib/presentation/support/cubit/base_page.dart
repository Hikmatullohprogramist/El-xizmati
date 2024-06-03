import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/di/get_it_injection.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/presentation/support/cubit/base_builder.dart';
import 'package:onlinebozor/presentation/support/cubit/base_event.dart';
import 'package:onlinebozor/presentation/support/cubit/base_state.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:flutter/services.dart';
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

  void shoasdaswDefaultBottomSheet(
      BuildContext context, String title, Widget body) {
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) => Container(),
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
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
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
              HapticFeedback.lightImpact();
            },
            backgroundColor: context.colors.buttonPrimary,
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }

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
            Center(child: message.s(16)),
            SizedBox(height: 32),
            Row(
              children: <Widget>[
                SizedBox(width: 16),
                Expanded(
                  child: CustomElevatedButton(
                    text: Strings.commonNo,
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
                    text: Strings.commonYes,
                    // backgroundColor: Color(0xFFEB2F69),
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
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

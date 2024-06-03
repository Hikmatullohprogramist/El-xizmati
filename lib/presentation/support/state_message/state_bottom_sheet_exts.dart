import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/state_message/state_message.dart';
import 'package:onlinebozor/presentation/support/state_message/state_message_type.dart';
import 'package:flutter/services.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';

extension StateBottomSheetExts on BuildContext {
  void showStateMessageBottomSheet(StateMessage message) =>
      showStateBottomSheet(message.titleOrDefault, message.message);

  void showStateBottomSheet(String title, String message, [MessageType type = MessageType.info]) {
    showCupertinoModalBottomSheet(
      context: this,
      builder: (BuildContext bc) {
        return Material(
          child: Container(
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
                    Navigator.pop(this);
                    HapticFeedback.lightImpact();
                  },
                  backgroundColor: colors.buttonPrimary,
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}

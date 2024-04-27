import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../gen/localization/strings.dart';
import '../../vibrator/vibrator_extension.dart';
import '../button/custom_elevated_button.dart';
import '../button/custom_outlined_button.dart';

extension ShowResultButtomSheet on BuildContext {
  void showResultButtomSheet() {
    showModalBottomSheet(
      context: this,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 32),
              Center(child: "Success".s(22).w(600)),
              SizedBox(height: 24),
              Center(child: "...".s(16)),
              SizedBox(height: 32),
              Row(
                children: <Widget>[
                  SizedBox(width: 16),
                  Expanded(
                    child: CustomOutlinedButton(
                      text: Strings.commonNo,
                      strokeColor: Colors.blueAccent,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: CustomOutlinedButton(
                      text: Strings.commonYes,
                      strokeColor: Colors.red,
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(width: 16),
                ],
              ),
              SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  void showErrorBottomSheet(BuildContext context,String title,String description) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          decoration: BoxDecoration(
            color: context.cardColor,
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
              Container(
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/ic_error.svg',
                    color: Colors.red,
                    width: 55,
                    height: 55,
                    // Replace with your SVG file path or provide SVG data directly
                  ),
                ),
              ),
              SizedBox(height: 14),
              Text(description,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 16),),
              SizedBox(height: 32),
              CustomElevatedButton(
                text: Strings.closeTitle,
                onPressed: () {
                  Navigator.pop(context);
                  vibrateAsHapticFeedback();
                },
                backgroundColor: context.colors.buttonPrimary,
              ),
              SizedBox(height:10),
            ],
          ),
        );
      },
    );
  }
}

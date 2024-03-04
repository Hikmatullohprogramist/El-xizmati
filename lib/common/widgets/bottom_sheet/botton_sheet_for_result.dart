import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../gen/localization/strings.dart';
import '../button/custom_outlined_button.dart';

extension ShowResultButtomSheet on BuildContext {
  void showResultButtomSheet() {
    showModalBottomSheet(
      context: this,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
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
}

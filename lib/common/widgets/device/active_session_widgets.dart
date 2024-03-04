import 'package:flutter/material.dart';
import 'package:onlinebozor/common/constants.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/common/widgets/button/custom_text_button.dart';
import 'package:onlinebozor/domain/models/active_sessions/active_session.dart';

import '../divider/custom_diverder.dart';

class ActiveSessionWidget extends StatelessWidget {
  const ActiveSessionWidget({
    super.key,
    required this.session,
    required this.onClicked,
  });

  final Function(ActiveSession session) onClicked;
  final ActiveSession session;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                if (session.user_agent.contains("Android"))
                  Assets.images.icPhone.svg(width: 24, height: 24)
                else
                  Assets.images.icLaptop.svg(width: 24, height: 24),
                SizedBox(width: 16),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "OnlineBozor app".w(700).s(12).c(Colors.black),
                    SizedBox(height: 6),
                    Flexible(
                        child: session.user_agent
                            .w(400)
                            .s(12)
                            .c(Color(0xFF41455E))
                            .copyWith(
                                overflow: TextOverflow.ellipsis, maxLines: 2)),
                    SizedBox(height: 6),
                    Flexible(
                      child: (session.lastActivityAt ?? "")
                          .w(400)
                          .s(12)
                          .c(Color(0xFF9EABBE))
                          .copyWith(overflow: TextOverflow.ellipsis),
                    ),
                    SizedBox(height: 8),
                    if (DeviceInfo.userAgent == session.user_agent)
                      Strings.activeDeviceCurrentDevice
                          .w(400)
                          .c(Color(0xFF32B88B))
                          .s(12)
                    else
                      CustomTextButton(
                        text: Strings.activeDeviceRemoveDevice,
                        onPressed: () => onClicked(session),
                        textColor: Color(0x1EF66412),
                      )
                  ],
                ))
              ],
            ),
          ),
        ),
        CustomDivider(
          height: 1,
        ),
        SizedBox(
          height: 2,
        )
      ],
    );
  }
}

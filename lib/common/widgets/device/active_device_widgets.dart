import 'package:flutter/material.dart';
import 'package:onlinebozor/common/constants.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';
import 'package:onlinebozor/data/responses/device/active_device_response.dart';

import '../divider/custom_diverder.dart';

class ActiveDeviceWidget extends StatelessWidget {
  const ActiveDeviceWidget(
      {super.key,
        required this.response,
        required this.invoke});

  final Function(ActiveDeviceResponse response) invoke;
  final ActiveDeviceResponse response;

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
                if (response.user_agent.contains("Android"))
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
                        child: response.user_agent
                            .w(400)
                            .s(12)
                            .c(Color(0xFF41455E))
                            .copyWith(overflow: TextOverflow.ellipsis, maxLines: 2)),
                    SizedBox(height: 6),
                    Flexible(
                      child: "${response.last_login_at}- ${response.last_activity_at}"
                          .w(400)
                          .s(12)
                          .c(Color(0xFF9EABBE))
                          .copyWith(overflow: TextOverflow.ellipsis),
                    ),
                    SizedBox(height: 8),
                    if (DeviceInfo.userAgent == response.user_agent)
                      Strings.activeDeviceCurrentDevice
                          .w(400)
                          .c(Color(0xFF32B88B))
                          .s(12)
                    else
                      TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0x1EF66412)),
                          onPressed: () {
                            invoke(response);
                          },
                          child: Strings.activeDeviceRemoveDevice
                              .w(600)
                              .c(Color(0xFFF66412))
                              .s(12))
                  ],
                ))
              ],
            ),
          ),
        ),
        CustomDivider(height: 1,),
        SizedBox(height: 2,)
      ],
    );
  }
}

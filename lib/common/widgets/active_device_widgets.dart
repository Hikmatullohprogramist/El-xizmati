import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';

class ActiveDeviceWidget extends StatelessWidget {
  const ActiveDeviceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Assets.images.icPhone.svg(width: 24, height: 24),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "OnlineBozor app".w(700).s(12).c(Colors.black),
              SizedBox(height: 6),
              "Desktop Mac OS X".w(400).s(12).c(Color(0xFF41455E)),
              SizedBox(height: 6),
              "06.02.2023 - 12:37:45".w(400).s(12).c(Color(0xFF9EABBE)),
              SizedBox(height: 8),
              "Текущий сеанс".w(400).c(Color(0xFF32B88B)).s(12),
              TextButton(
                  style:
                      TextButton.styleFrom(backgroundColor: Color(0x1EF66412)),
                  onPressed: () {},
                  child: "Завершить сеанс".w(600).c(Color(0xFFF66412)).s(12))
            ],
          )
        ],
      ),
    );
  }
}

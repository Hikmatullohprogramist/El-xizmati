import 'package:flutter/material.dart';
import 'package:onlinebozor/common/vibrator/vibrator_extension.dart';

import '../../gen/assets/assets.gen.dart';

class OrderAdRemoveWidget extends StatelessWidget {
  const OrderAdRemoveWidget({
    super.key,
    required this.onClicked,
    this.size = 32,
  });

  final VoidCallback onClicked;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: () {
          onClicked();
          vibrateAsHapticFeedback();
        },
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              width: 1,
              color: Color(0xFFDFE2E9),
            ),
          ),
          height: size,
          width: size,
          child: Assets.images.icDelete.svg(color: Colors.red),
        ),
      ),
    );
  }
}

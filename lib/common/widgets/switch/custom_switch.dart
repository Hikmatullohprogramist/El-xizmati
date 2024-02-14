import 'package:flutter/material.dart';
import 'package:onlinebozor/common/vibrator/vibrator_extension.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  CustomSwitch({required this.value, required this.onChanged});

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    var switchColor = widget.value ? Color(0xFF5C6AC4) : Color(0xFFAEB2CD);

    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
        vibrateByTactile();
      },
      child: Container(
        width: 55,
        height: 31, // Assuming this is the height from your image
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: switchColor.withAlpha(30),
          border: Border.all(
            width: 2,
            color: switchColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          // Space between the thumb and the track
          child: AnimatedAlign(
            alignment:
                widget.value ? Alignment.centerRight : Alignment.centerLeft,
            duration: Duration(milliseconds: 120),
            curve: Curves.easeIn,
            child: Container(
              width: 22, // Thumb width
              height: 22, // Thumb height
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: switchColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

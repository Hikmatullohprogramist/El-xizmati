import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:flutter/services.dart';

class CustomToggle extends StatefulWidget {
  CustomToggle({
    this.width = double.infinity,
    required this.isChecked,
    required this.onChanged,
    required this.negativeTitle,
    required this.positiveTitle,
  });

  final double width;
  final bool isChecked;
  final ValueChanged<bool> onChanged;
  final String negativeTitle;
  final String positiveTitle;

  @override
  _CustomToggleState createState() => _CustomToggleState();
}

class _CustomToggleState extends State<CustomToggle> {
  @override
  Widget build(BuildContext context) {
    var negativeColor =
        !widget.isChecked ? Color(0xFF5C6AC4) : Color(0xFFFBFAFF);
    var negativeTextColor =
        !widget.isChecked ? Color(0xFFFFFFFF) : Color(0xFFAEB2CD);

    var positiveColor =
        widget.isChecked ? Color(0xFF5C6AC4) : Color(0xFFFBFAFF);
    var positiveTextColor =
        widget.isChecked ? Color(0xFFFFFFFF) : Color(0xFFAEB2CD);

    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.isChecked);
        HapticFeedback.selectionClick();
      },
      child: Container(
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xFFFBFAFF),
          border: Border.all(
            width: 1,
            color: Color(0xFFDFE2E9),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6),
          // Space between the thumb and the track
          child: AnimatedAlign(
            alignment:
                widget.isChecked ? Alignment.centerRight : Alignment.centerLeft,
            duration: Duration(milliseconds: 120),
            curve: Curves.easeIn,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Container(
                    width: 120,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: negativeColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: widget.isChecked
                            ? Radius.circular(0)
                            : Radius.circular(8),
                        bottomRight: widget.isChecked
                            ? Radius.circular(0)
                            : Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                      shape: BoxShape.rectangle,
                    ),
                    child: widget.negativeTitle
                        .c(negativeTextColor)
                        .s(14)
                        .w(600)
                        .copyWith(textAlign: TextAlign.center),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 120,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: positiveColor,
                      borderRadius: BorderRadius.only(
                        topLeft: widget.isChecked
                            ? Radius.circular(8)
                            : Radius.circular(0),
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                        bottomLeft: widget.isChecked
                            ? Radius.circular(8)
                            : Radius.circular(0),
                      ),
                      shape: BoxShape.rectangle,
                    ),
                    child: widget.positiveTitle
                        .c(positiveTextColor)
                        .s(14)
                        .w(600)
                        .copyWith(textAlign: TextAlign.center),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

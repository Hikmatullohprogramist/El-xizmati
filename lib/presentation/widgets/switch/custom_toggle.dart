import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/presentation/support/colors/static_colors.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';

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
    final negativeColor =
        !widget.isChecked ? StaticColors.buttonColor : Colors.transparent;
    final negativeTextColor =
        !widget.isChecked ? Color(0xFFFFFFFF) : Color(0xFFAEB2CD);

    final positiveColor =
        widget.isChecked ? StaticColors.buttonColor : Colors.transparent;
    final positiveTextColor =
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
          color: context.inputBackgroundColor,
          border: Border.all(
            width: 1,
            color: context.inputStrokeInactiveColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(6),
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

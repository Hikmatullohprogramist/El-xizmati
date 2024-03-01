import 'package:flutter/material.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

class CustomDropdownField extends StatelessWidget {
  const CustomDropdownField({
    super.key,
    this.height = 50,
    this.text = "",
    required this.hint,
    required this.onTap,
  });

  final double height;
  final String text;
  final String hint;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Color(0xFFFAF9FF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Color(0xFFDFE2E9)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: (text.isNotEmpty
                        ? (text).w(400).s(14).c(Color(0xFF41455E))
                        : (hint).w(400).s(14).c(Color(0xFF9EABBE)))
                    .copyWith(maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
              Icon(Icons.keyboard_arrow_down, color: Color(0xFF9EABBE))
            ],
          ),
        ),
      ),
    );
  }
}

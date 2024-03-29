import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/static_colors.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

class CustomDropdownFormField extends FormField<String> {
  final double height;
  final String value;
  final String hint;
  final Function() onTap;

  CustomDropdownFormField({
    super.key,
    this.height = 50,
    this.value = "",
    required this.hint,
    required this.onTap,
    validator,
    autovalidateMode,
  }) : super(
          // onSaved: onSaved,
          initialValue: value,
          validator: validator,
          autovalidateMode: autovalidateMode,
          builder: (state) {
            return Column(
              children: [
                Container(
                  height: height,
                  decoration: BoxDecoration(
                    color: StaticColors.inputBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 1,
                      color: state.hasError
                          ? Colors.red.shade200
                          : StaticColors.inputStrokeColor,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: InkWell(
                      onTap: onTap,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: (value.isNotEmpty
                                    ? (value).w(400).s(14).c(Color(0xFF41455E))
                                    : (hint).w(400).s(14).c(Color(0xFF9EABBE)))
                                .copyWith(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                          ),
                          Icon(Icons.keyboard_arrow_down,
                              color: Color(0xFF9EABBE))
                        ],
                      ),
                    ),
                  ),
                ),
                // if (state.hasError)
                SizedBox(height: 8),
                // if (state.hasError)
                (state.errorText ?? "test").s(12).c(Colors.red).copyWith(
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
              ],
            );
          },
        );
}

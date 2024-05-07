import 'package:flutter/material.dart';
import 'package:onlinebozor/core/colors/static_colors.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';

class CustomDropdownFormField extends StatelessWidget {
  const CustomDropdownFormField({
    super.key,
    this.height = 50,
    this.value = "",
    required this.hint,
    required this.onTap,
    this.autoValidateMode,
    this.validator,
  });

  final double height;
  final String value;
  final String hint;
  final Function() onTap;
  final AutovalidateMode? autoValidateMode;
  final String? Function(String? text)? validator;

  @override
  Widget build(BuildContext context) {
    return FormField(
      validator: (v) {
        return validator != null ? validator!(value) : null;
      },
      builder: (state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                  onTap: () {
                    onTap();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: (value.isNotEmpty
                                ? (value).w(400).s(14).c(Color(0xFF41455E))
                                : (hint).w(400).s(14).c(Color(0xFF9EABBE)))
                            .copyWith(
                                maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                      Assets.images.icDropdown.svg()
                    ],
                  ),
                ),
              ),
            ),
            if (state.hasError) SizedBox(height: 8),
            if (state.hasError)
              Row(
                children: [
                  SizedBox(width: 16),
                  (state.errorText!).s(12).c(Colors.red).copyWith(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                ],
              ),
          ],
        );
      },
    );
  }
}

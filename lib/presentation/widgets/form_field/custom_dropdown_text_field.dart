import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/colors/color_extension.dart';

class CustomDropDownTextField extends StatefulWidget {
  const CustomDropDownTextField({
    Key? key,
    required this.onTap,
    this.autofillHints,
    this.enableSuggestions,
    this.hint,
    this.controller,
    this.inputType,
    this.readOnly = false,
    this.enabled = true,
    this.disabledColor,
    this.label,
    this.onChanged,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  final Iterable<String>? autofillHints;
  final bool? enableSuggestions;
  final String? hint;
  final String? label;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final bool readOnly;
  final bool enabled;
  final TextAlign textAlign;
  final Color? disabledColor;

  final Function() onTap;
  final Function(String text)? onChanged;

  @override
  State<CustomDropDownTextField> createState() =>
      _CustomDropDownTextFieldState();
}

class _CustomDropDownTextFieldState extends State<CustomDropDownTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      // style: TextStyle(),
      items: [],
      onTap: () => widget.onTap,
      onChanged: (Object? value) {},
      decoration: InputDecoration(
          filled: true,
          focusColor: Colors.white,
          fillColor: Color(0xFFFAF9FF),
          hintText: widget.hint,
          hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          isDense: false,
          counter: Offstage(),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          labelText: widget.label,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFDFE2E9)),
            borderRadius: BorderRadius.circular(8),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFDFE2E9)),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: context.colors.buttonPrimary),
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: null),
    );
  }
}

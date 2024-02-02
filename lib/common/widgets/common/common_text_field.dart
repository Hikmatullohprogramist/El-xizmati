import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField({
    Key? key,
    this.autofillHints,
    this.enableSuggestions,
    this.hint,
    this.controller,
    this.inputType,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.minLines,
    this.maxLines = 1,
    this.enabled = true,
    this.disabledColor,
    this.label,
    this.onChanged,
    this.inputFormatters,
    this.textInputAction,
    this.maxLength = 1000,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  final Iterable<String>? autofillHints;
  final bool? enableSuggestions;
  final String? hint;
  final String? label;
  final TextInputType? inputType;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool obscureText;
  final bool readOnly;
  final int? minLines;
  final int? maxLines;
  final int maxLength;
  final bool enabled;
  final TextAlign textAlign;
  final Color? disabledColor;
  final TextInputAction? textInputAction;
  final TextInputFormatter? inputFormatters;
  final Function(String text)? onChanged;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool _passwordVisible = true;

  @override
  void initState() {
    super.initState();
    _passwordVisible = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofillHints: widget.autofillHints,
      textAlign: widget.textAlign,
      textAlignVertical: TextAlignVertical.center,
      // style: TextStyle(),
      controller: widget.controller,
      keyboardType: widget.inputType,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      enableSuggestions: widget.enableSuggestions ?? true,
      textInputAction: widget.textInputAction,
      onChanged: widget.onChanged,
      inputFormatters: [
        if (widget.inputFormatters != null) widget.inputFormatters!
      ],
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
        suffixIcon: !widget.obscureText
            ? null
            : IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
      ),
      obscureText: _passwordVisible,
    );
  }
}

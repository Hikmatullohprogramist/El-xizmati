import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlinebozor/core/colors/color_extension.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    this.height = 58,
    this.autofillHints,
    this.enableSuggestions,
    this.hint,
    this.prefixText,
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
    this.validator,
    this.autoValidateMode,
    this.textCapitalization,
  }) : super(key: key);

  final double? height;
  final Iterable<String>? autofillHints;
  final bool? enableSuggestions;
  final String? hint;
  final String? label;
  final String? prefixText;
  final TextInputType? inputType;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool obscureText;
  final bool readOnly;
  final int? minLines;
  final int? maxLines;
  final int maxLength;
  final bool enabled;
  final TextCapitalization? textCapitalization;
  final TextAlign textAlign;
  final Color? disabledColor;
  final TextInputAction? textInputAction;
  final TextInputFormatter? inputFormatters;
  final Function(String text)? onChanged;
  final AutovalidateMode? autoValidateMode;
  final String? Function(String? text)? validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  bool _passwordVisible = true;

  @override
  void initState() {
    super.initState();
    log("init");
    _focusNode.addListener(_handleFocusChange);
    _passwordVisible = widget.obscureText;
  }

  void _handleFocusChange() {
    log("init2");
    if (_focusNode.hasFocus != _isFocused) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextFormField(
        validator: widget.validator,
        focusNode: _focusNode,
        autofillHints: widget.autofillHints,
        textAlign: widget.textAlign,
        textAlignVertical: TextAlignVertical.center,
        autovalidateMode: widget.autoValidateMode,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Color(0xFF41455F),
        ),
        textCapitalization:
            widget.textCapitalization ?? TextCapitalization.none,
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
        inputFormatters:
            widget.inputFormatters != null ? [widget.inputFormatters!] : null,
        decoration: InputDecoration(
          filled: true,
          hintText: widget.hint,
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF9EABBE),
          ),
          // prefixText: widget.prefixText,
          prefix: widget.prefixText == null
              ? null
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.prefixText ?? "",
                    ),
                    Container(
                      width: 1,
                      margin: EdgeInsets.fromLTRB(6, 5, 10, 4),
                      color: _isFocused ? Color(0xFF5C6AC4) : Color(0xFFDFE2E9),
                    )
                  ],
                ),
          prefixStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF41455F),
          ),
          isDense: false,
          counter: Offstage(),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          labelText: widget.label,
          labelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF41455F),
          ),
          focusColor: Color(0xFFFFFFFF),
          fillColor: _isFocused ? Color(0xFFFFFFFF) : Color(0xFFFBFAFF),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFDFE2E9)),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
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
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade200),
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
      ),
    );
  }
}

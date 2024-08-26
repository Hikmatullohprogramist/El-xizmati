import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    Key? key,
    this.height = 60,
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
    this.enabledColor,
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
    this.isStrokeEnabled = true,
    this.endIcon,
  }) : super(key: key);

  final double? height;

  //
  final String? hint;
  final String? label;
  final String? prefixText;

  //
  final Iterable<String>? autofillHints;
  final bool? enableSuggestions;
  final TextInputType? inputType;
  final TextInputType? keyboardType;

  //
  final TextEditingController? controller;

  //
  final bool obscureText;
  final bool readOnly;
  final int? minLines;
  final int? maxLines;
  final int maxLength;

  //
  final bool enabled;
  final TextCapitalization? textCapitalization;
  final TextAlign textAlign;
  final TextInputAction? textInputAction;
  final TextInputFormatter? inputFormatters;

  //
  final Function(String text)? onChanged;

  //
  final AutovalidateMode? autoValidateMode;
  final String? Function(String? text)? validator;

  //
  final Color? enabledColor;
  final Color? disabledColor;
  final bool isStrokeEnabled;
  final Widget? endIcon;

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
    return TextFormField(
      validator: widget.validator,
      focusNode: _focusNode,
      autofillHints: widget.autofillHints,
      textAlign: widget.textAlign,
      textAlignVertical: TextAlignVertical.center,
      autovalidateMode: widget.autoValidateMode,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: context.textPrimary,
      ),
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
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
      inputFormatters: widget.inputFormatters != null ? [widget.inputFormatters!] : null,
      decoration: InputDecoration(
        filled: true,
        hintText: widget.hint,
        hintStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: context.textSecondary,
        ),
        // prefixText: widget.prefixText,
        prefixIcon: widget.prefixText == null
            ? null
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 12),
                  (widget.prefixText ?? "").c(context.textPrimary),
                  SizedBox(width: 8),
                  Container(
                    width: 1,
                    margin: EdgeInsets.fromLTRB(6, 5, 10, 4),
                    color: _isFocused ? Color(0xFF5C6AC4) : Color(0xFFDFE2E9),
                  ),
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
        // focusColor: Color(0xFFFFFFFF),
        fillColor: widget.enabledColor ?? context.inputBackgroundColor,
        //_isFocused ? context.backgroundWhiteColor : context.backgroundWhiteColor,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isStrokeEnabled
                ? context.inputStrokeInactiveColor
                : Colors.transparent,
            width: 2
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isStrokeEnabled
                ? context.inputStrokeActiveColor
                : Colors.transparent,
            width: 2
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isStrokeEnabled
                ? context.inputStrokeActiveColor
                : Colors.transparent,
            width: 2
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isStrokeEnabled
                ? context.inputStrokeActiveColor
                : Colors.transparent,
            width: 2
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isStrokeEnabled
                ? Colors.red.shade200
                : Colors.transparent,
            width: 2
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        suffixIcon: !widget.obscureText? widget.endIcon : IconButton(
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

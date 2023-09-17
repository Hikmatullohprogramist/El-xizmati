import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField({
    Key? key,
    this.hint,
    this.controller,
    this.inputType,
    this.obscureText = false,
    this.readOnly = false,
    this.minLines,
    this.maxLines = 1,
    this.enabled = true,
    this.disabledColor,
    this.label,
    this.onChanged,
    this.inputFormatters,
  }) : super(key: key);

  final String? hint;
  final String? label;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final bool obscureText;
  final bool readOnly;
  final int? minLines;
  final int? maxLines;
  final bool enabled;
  final Color? disabledColor;
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
      controller: widget.controller,
      keyboardType: widget.inputType,
      minLines: widget.minLines,
      readOnly: widget.readOnly,
      maxLines: widget.maxLines,
      enabled: widget.enabled,
      onChanged: widget.onChanged,
      inputFormatters: [
        if (widget.inputFormatters != null) widget.inputFormatters!
      ],
      decoration: InputDecoration(
        hintText: widget.hint,
        labelText: widget.label,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: context.colors.primary),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class CustomTextEditingController extends TextEditingController {
  final TextInputFormatter? formatter;
  TextEditingValue oldValue = TextEditingValue();

  CustomTextEditingController(this.formatter) : super(text: '');

  // @override
  // set text(String newText) {
  //   var newValue = TextEditingValue(text: newText);
  //   var actualValue =
  //       formatter?.formatEditUpdate(oldValue, newValue) ?? newValue;
  //   oldValue = actualValue;
  //   super.text = actualValue.text;
  //   // super.text = newText;
  // }

@override
set value(TextEditingValue newValue) {
  // final text = formatter.format(text);
  // if (_controller.text != text) {
  //   _controller.value = _controller.value.copyWith(
  //     text: text,
  //     selection: TextSelection.collapsed(offset: text.length),
  //   );
  // }

  var actualValue = formatter?.formatEditUpdate(oldValue, newValue) ?? newValue;
  if(oldValue.text != actualValue.text) {
    oldValue = actualValue;
    // super.value = actualValue;
    super.value = value.copyWith(
      text: actualValue.text,
      selection: TextSelection.collapsed(offset: actualValue.text.length),
    );
  }
}

  void updateOnRestore(String? stateValue) {
    text = (text != stateValue ? text = stateValue ?? "" : text);
  }
}

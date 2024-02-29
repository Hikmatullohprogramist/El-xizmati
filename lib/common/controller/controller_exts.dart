import 'package:flutter/cupertino.dart';

extension RestoreExts on TextEditingController {
  void updateOnRestore(String? stateValue) {
    text != stateValue ? text = stateValue ?? "" : text = text;
  }
}

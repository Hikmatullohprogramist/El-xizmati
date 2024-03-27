import 'package:flutter/cupertino.dart';

extension RestoreExts on TextEditingController {
  void updateOnRestore(String? stateValue) {
    text = (text != stateValue ? stateValue ?? "" : text);
  }
}

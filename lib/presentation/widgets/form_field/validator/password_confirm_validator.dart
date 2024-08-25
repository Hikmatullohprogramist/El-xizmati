import 'package:El_xizmati/core/gen/localization/strings.dart';

class PasswordConfirmValidator {
  static String? validate(String? password, String? confirm) {
    if (confirm == null || confirm.isEmpty) {
      return Strings.commonErrorFieldIsRequired;
    }

    if (password != confirm) {
      return Strings.commonErrorPasswordConfirm;
    }

    return null;
  }
}

import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../gen/localization/strings.dart';

class PhoneNumberValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.commonErrorFieldIsRequired;
    }

    final clearedValue = value.clearPhoneNumber();
    if (clearedValue.length != 9) {
      return Strings.commonErrorPhoneNotValid;
    }

    return null;
  }
}

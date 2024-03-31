import 'package:logger/logger.dart';

import '../../../gen/localization/strings.dart';

class DefaultValidator {
  static String? validate(String? value) {
    String? errorMessage;
    if (value == null || value.trim().isEmpty) {
      // return Strings.commonErrorFieldIsRequired;
      errorMessage = Strings.commonErrorFieldIsRequired;
    }

    Logger().w("value for validate = $value, error = $errorMessage");
    return errorMessage;
  }
}

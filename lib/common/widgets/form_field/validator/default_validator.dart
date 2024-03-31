import '../../../gen/localization/strings.dart';

class DefaultValidator {
  static String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return Strings.commonErrorFieldIsRequired;
    }

    return null;
  }
}

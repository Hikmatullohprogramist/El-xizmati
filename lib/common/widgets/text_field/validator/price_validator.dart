import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../gen/localization/strings.dart';

class PriceValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.commonErrorFieldIsRequired;
    }

    final clearedValue = int.tryParse(value.clearPrice());
    if (clearedValue == null || clearedValue == 0) {
      return Strings.commonErrorPriceNotValid;
    }

    return null;
  }
}

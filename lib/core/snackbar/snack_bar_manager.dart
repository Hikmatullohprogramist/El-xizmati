import 'package:onlinebozor/core/snackbar/snack_bar_message.dart';

abstract class SnackBarManager {
  void setOnShowListener(
    void Function(SnackBarMessage message) onShowListener,
  );

  void error(String description, [String? title]);

  void warning(String description, [String? title]);

  void info(String description, [String? title]);

  void success(String description, [String? title]);
}

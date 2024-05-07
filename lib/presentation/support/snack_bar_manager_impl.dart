import 'package:injectable/injectable.dart';
import 'package:onlinebozor/core/snackbar/snack_bar_manager.dart';
import 'package:onlinebozor/core/snackbar/snack_bar_message.dart';
import 'package:onlinebozor/core/snackbar/snack_bar_message_type.dart';

@Singleton(as: SnackBarManager)
class SnackBarManagerImpl extends SnackBarManager {
  void Function(SnackBarMessage message)? _onShowListener;

  void _show(SnackBarMessageType type, String description, [String? title]) =>
      _onShowListener?.call(
        SnackBarMessage(
          type,
          description,
          title,
        ),
      );

  @override
  void error(String description, [String? title]) => _show(
        SnackBarMessageType.error,
        description,
        title,
      );

  @override
  void warning(String description, [String? title]) => _show(
        SnackBarMessageType.warning,
        description,
        title,
      );

  @override
  void info(String description, [String? title]) => _show(
        SnackBarMessageType.info,
        description,
        title,
      );

  @override
  void success(String description, [String? title]) => _show(
        SnackBarMessageType.success,
        description,
        title,
      );

  @override
  void setOnShowListener(
      void Function(SnackBarMessage message) onShowListener) {
    _onShowListener = onShowListener;
    // fixme for disallowing showing  toasts
  }
}

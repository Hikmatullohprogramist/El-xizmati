import 'snack_bar_message_type.dart';

class SnackBarMessage {
  final SnackBarMessageType type;
  final String description;
  final String? title;

  SnackBarMessage(this.type, this.description, [this.title]);
}

import 'state_message_type.dart';

class StateMessage {
  final MessageType type;
  final String message;
  final String? title;

  StateMessage(this.type, this.message, [this.title]);
}

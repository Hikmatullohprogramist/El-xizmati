import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../common/base/base_cubit.dart';

part 'message_cubit.freezed.dart';

part 'message_state.dart';

@injectable
class MessageCubit extends BaseCubit<MessageBuildable, MessageListenable> {
  MessageCubit() : super(MessageBuildable());
}

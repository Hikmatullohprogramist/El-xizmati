import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../common/core/base_cubit.dart';

part 'chat_cubit.freezed.dart';

part 'chat_state.dart';

@Injectable()
class ChatCubit extends BaseCubit<ChatBuildable, ChatListenable> {
  ChatCubit() : super(const ChatBuildable());
}

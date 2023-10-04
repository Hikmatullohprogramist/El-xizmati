import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'chat_list_cubit.freezed.dart';

part 'chat_list_state.dart';

@injectable
class ChatListCubit extends BaseCubit<ChatListBuildable, ChatListListenable> {
  ChatListCubit() : super(const ChatListBuildable());
}

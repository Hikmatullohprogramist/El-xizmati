import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../../common/core/base_cubit.dart';

part 'saved_chats_cubit.freezed.dart';

part 'saved_chats_state.dart';

@injectable
class SavedChatsCubit
    extends BaseCubit<SavedChatsBuildable, SavedChatsListenable> {
  SavedChatsCubit() : super(const SavedChatsBuildable());
}

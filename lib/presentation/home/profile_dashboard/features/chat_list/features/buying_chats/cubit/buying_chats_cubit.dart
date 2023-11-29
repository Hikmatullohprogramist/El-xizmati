import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../common/core/base_cubit.dart';

part 'buying_chats_cubit.freezed.dart';

part 'buying_chats_state.dart';

@injectable
class BuyingChatsCubit
    extends BaseCubit<BuyingChatsBuildable, BuyingChatsListenable> {
  BuyingChatsCubit() : super(const BuyingChatsBuildable());
}

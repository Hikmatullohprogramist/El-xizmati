import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../../common/core/base_cubit.dart';

part 'selling_chats_cubit.freezed.dart';

part 'selling_chats_state.dart';

@injectable
class SellingChatsCubit
    extends BaseCubit<SellingChatsBuildable, SellingChatsListenable> {
  SellingChatsCubit() : super(const SellingChatsBuildable());
}

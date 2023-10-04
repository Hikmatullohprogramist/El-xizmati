import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'selling_chats_cubit.freezed.dart';

part 'selling_chats_state.dart';

@injectable
class SellingChatsCubit
    extends BaseCubit<SellingChatsBuildable, SellingChatsListenable> {
  SellingChatsCubit() : super(const SellingChatsBuildable());
}

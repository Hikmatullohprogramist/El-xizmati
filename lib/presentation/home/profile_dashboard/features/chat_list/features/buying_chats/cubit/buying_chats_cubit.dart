import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'buying_chats_state.dart';
part 'buying_chats_cubit.freezed.dart';

@injectable
class BuyingChatsCubit extends BaseCubit<BuyingChatsBuildable, BuyingChatsListenable> {
  BuyingChatsCubit() : super(const BuyingChatsBuildable());
}

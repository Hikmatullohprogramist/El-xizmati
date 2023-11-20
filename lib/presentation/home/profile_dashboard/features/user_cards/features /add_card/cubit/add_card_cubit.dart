import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'add_card_cubit.freezed.dart';

part 'add_card_state.dart';

@injectable
class AddCardCubit extends BaseCubit<AddCardBuildable, AddCardListenable> {
  AddCardCubit() : super(const AddCardBuildable());
}

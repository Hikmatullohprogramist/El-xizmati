import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/base/base_cubit.dart';

part 'card_cubit.freezed.dart';

part 'card_state.dart';

@injectable
class CardCubit extends BaseCubit<CardBuildable, CardListenable> {
  CardCubit() : super(CardBuildable());
}

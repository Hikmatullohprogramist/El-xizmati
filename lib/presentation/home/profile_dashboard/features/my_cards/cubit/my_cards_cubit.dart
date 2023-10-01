import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../common/core/base_cubit.dart';

part 'my_cards_cubit.freezed.dart';

part 'my_cards_state.dart';

@injectable
class MyCardsCubit extends BaseCubit<MyCardsBuildable, MyCardsListenable> {
  MyCardsCubit() : super(MyCardsBuildable());
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../common/core/base_cubit.dart';

part 'user_cards_cubit.freezed.dart';

part 'user_cards_state.dart';

@injectable
class UserCardsCubit extends BaseCubit<UserCardsBuildable, UserCardsListenable> {
  UserCardsCubit() : super(UserCardsBuildable());
}

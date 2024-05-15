import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'user_cards_cubit.freezed.dart';
part 'user_cards_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit() : super(PageState());
}

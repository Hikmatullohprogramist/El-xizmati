import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';

import '../../../../../data/repositories/state_repository.dart';

part 'set_language_cubit.freezed.dart';

part 'set_language_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.repository) : super(const PageState());

  StateRepository repository;

  Future<void> setLanguage(Language language) async {
    await repository.languageSelection(true);
    await repository.setLanguage(language.name);
    emitEvent(PageEvent(PageEventType.navigationAuthStart));
  }
}

enum Language { uz, ru, kr }

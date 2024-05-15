import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/repositories/state_repository.dart';
import 'package:onlinebozor/domain/models/language/language.dart';

import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';

part 'change_language_cubit.freezed.dart';
part 'change_language_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.repository) : super(PageState()) {
    getLanguage();
  }

  StateRepository repository;

  Future<void> selectLanguage(Language language) async {
    updateState((state) => state.copyWith(language: language));
    await repository.setLanguage(states.language!);
  }

  Future<void> getLanguage() async {
    try {
      final language = await repository.getLanguage();
      updateState((state) => state.copyWith(language: language));
    } catch (e) {
      logger.w(e);
    }
  }
}

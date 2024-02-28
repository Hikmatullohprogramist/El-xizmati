import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../common/core/base_cubit.dart';
import '../../../../../data/repositories/state_repository.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.repository) : super(PageState()) {
    getLanguage();
  }

  StateRepository repository;

  Future<void> selectLanguage(Language language) async {
    updateState((state) => state.copyWith(language: language));
    await repository.setLanguage(states.language!.name);
  }

  Future<void> getLanguage() async {
    try {
      final languageName = await repository.getLanguageName();
      late Language language;
      if (languageName == 'uz') {
        language = Language.uzbekLatin;
      } else {
        if (languageName == 'ru') {
          language = Language.russian;
        } else {
          language = Language.uzbekCyrill;
        }
      }
      updateState((state) => state.copyWith(language: language));
    } catch (e) {}
  }

// Future<void> saveSelectedLanguage() async {
//   try {
//     if (state.language != null) {
//       // invoke(ChangeLanguageListenable(ChangeLanguageEffect.backTo));
//     }
//   } catch (e) {}
// }
}

enum Language { uzbekLatin, russian, uzbekCyrill }

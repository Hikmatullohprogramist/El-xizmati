import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';
import 'package:onlinebozor/domain/repository/state_repository.dart';

part 'change_language_cubit.freezed.dart';
part 'change_language_state.dart';

@Injectable()
class ChangeLanguageCubit
    extends BaseCubit<ChangeLanguageBuildable, ChangeLanguageListenable> {
  ChangeLanguageCubit(this.stateRepository) : super(ChangeLanguageBuildable()) {
    getLanguage();
  }

  StateRepository stateRepository;

  Future<void> selectLanguage(Language language) async {
    build((buildable) => buildable.copyWith(language: language));
    await stateRepository.setLanguage(buildable.language!.name);
  }

  Future<void> getLanguage() async {
    try {
      final languageName = await stateRepository.getLanguageName();
      late Language language;
      if (languageName == 'uz') {
        language = Language.uz;
      } else {
        language = Language.ru;
      }
      build((buildable) => buildable.copyWith(language: language));
    } catch (e) {}
  }

  // Future<void> saveSelectedLanguage() async {
  //   try {
  //     if (buildable.language != null) {
  //       // invoke(ChangeLanguageListenable(ChangeLanguageEffect.backTo));
  //     }
  //   } catch (e) {}
  // }
}

enum Language { uz, ru }

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:El_xizmati/data/repositories/language_repository.dart';
import 'package:El_xizmati/domain/models/language/language.dart';
import 'package:El_xizmati/presentation/support/cubit/base_cubit.dart';

part 'set_language_cubit.freezed.dart';
part 'set_language_state.dart';

@injectable
class SetLanguageCubit extends BaseCubit<SetLanguageState, SetLanguageEvent> {
  final LanguageRepository _languageRepository;

  SetLanguageCubit(this._languageRepository) : super(const SetLanguageState()) {
    setLanguage(Language.uzbekLatin);
  }

  void getLanguage() => _languageRepository.getLanguage();

  bool get isRussianSelected =>
      _languageRepository.getLanguage() == Language.russian;

  bool get isUzbekLatinSelected =>
      _languageRepository.getLanguage() == Language.uzbekLatin;

  bool get isUzbekCyrillSelected =>
      _languageRepository.getLanguage() == Language.uzbekCyrill;

  Future<void> setLanguage(Language language) async {
    await _languageRepository.setLanguage(language);
  }
}

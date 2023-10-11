import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/storage/language_storage.dart';
import 'package:onlinebozor/domain/repo/state_repository.dart';

@LazySingleton(as: StateRepository)
class StateRepositoryImp extends StateRepository {
  StateRepositoryImp(this.languageStorage);

  final LanguageStorage languageStorage;

  @override
  Future<String?> getLanguageName() async {
    return languageStorage.languageName.call();
  }

  @override
  Future<bool?> isLanguageSelection() async {
    return languageStorage.isLanguageSelection.call();
  }

  @override
  Future<void> languageSelection(bool selection) {
    return languageStorage.isLanguageSelection.set(selection);
  }

  @override
  Future<void> setLanguage(String languageName) {
    return languageStorage.languageName.set(languageName);
  }
}

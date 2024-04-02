import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/models/language/language.dart';

import '../../data/storages/categories_storage.dart';
import '../../data/storages/language_storage.dart';
import '../../data/storages/token_storage.dart';

@LazySingleton()
class StateRepository {
  StateRepository(
    this.languageStorage,
    this.tokenStorage,
    this.categoriesStorage,
  );

  final LanguageStorage languageStorage;
  final TokenStorage tokenStorage;
  final CategoriesStorage categoriesStorage;

  Future<Language> getLanguage() async {
    var languageName = languageStorage.languageName.call();
    Language language = Language.uzbekLatin;

    language = languageName == Language.uzbekCyrill.name
        ? Language.uzbekCyrill
        : languageName == Language.russian.name
            ? Language.russian
            : Language.uzbekLatin;

    return language;
  }

  Future<bool?> isLanguageSelection() async {
    return languageStorage.isLanguageSelection.call();
  }

  Future<void> languageSelection(bool selection) {
    categoriesStorage.categories.clear();
    return languageStorage.isLanguageSelection.set(selection);
  }

  Future<void> setLanguage(String languageName) {
    return languageStorage.languageName.set(languageName);
  }

  Future<void> setLogin(bool isLogin) {
    return tokenStorage.isLogin.set(isLogin);
  }

  Future<bool?> isLogin() async {
    return tokenStorage.isLogin.call();
  }

  Future<void> clear() async {
    await tokenStorage.isLogin.clear();
    await tokenStorage.token.clear();
  }
}

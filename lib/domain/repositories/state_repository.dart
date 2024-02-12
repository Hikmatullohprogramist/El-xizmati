import 'package:injectable/injectable.dart';

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

  Future<String?> getLanguageName() async {
    return languageStorage.languageName.call();
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

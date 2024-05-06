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
    return languageStorage.language;
  }

  Future<bool> isLanguageSelection() async {
    return languageStorage.isLanguageSelected;
  }

  Future<void> setLanguage(Language language) {
    categoriesStorage.clear();

    return languageStorage.setLanguage(language);
  }

  Future<void> setLogin(bool isLogin) {
    return tokenStorage.setLoginState(isLogin);
  }

  Future<bool> isUserLoggedIn() async {
    return tokenStorage.isUserLoggedIn;
  }

  Future<void> clear() async {
    await tokenStorage.clear();
  }
}

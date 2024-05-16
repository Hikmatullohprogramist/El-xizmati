import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/hive/storages/categories_storage.dart';
import 'package:onlinebozor/data/datasource/hive/storages/language_storage.dart';
import 'package:onlinebozor/data/datasource/hive/storages/token_storage.dart';
import 'package:onlinebozor/domain/models/language/language.dart';

@LazySingleton()
class StateRepository {
  StateRepository(
    this._categoriesStorage,
    this._languageStorage,
    this._tokenStorage,
  );

  final CategoriesStorage _categoriesStorage;
  final LanguageStorage _languageStorage;
  final TokenStorage _tokenStorage;

  Future<Language> getLanguage() async {
    return _languageStorage.language;
  }

  bool isLanguageSelection() {
    return _languageStorage.isLanguageSelected;
  }

  Future<void> setLanguage(Language language) {
    _categoriesStorage.clear();

    return _languageStorage.setLanguage(language);
  }

  Future<void> setLogin(bool isLogin) {
    return _tokenStorage.setLoginState(isLogin);
  }

  bool isUserLoggedIn() {
    return _tokenStorage.isUserLoggedIn;
  }

  bool isNotAuthorized() {
    return !_tokenStorage.isUserLoggedIn;
  }

  Future<void> clear() async {
    await _tokenStorage.clear();
  }
}

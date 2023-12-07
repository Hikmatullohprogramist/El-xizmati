import 'package:injectable/injectable.dart';
import 'package:onlinebozor/domain/repositories/state_repository.dart';

import '../storages/categories_storage.dart';
import '../storages/language_storage.dart';
import '../storages/token_storage.dart';

@LazySingleton(as: StateRepository)
class StateRepositoryImp extends StateRepository {
  StateRepositoryImp(
      this.languageStorage, this.tokenStorage, this.categoriesStorage);

  final LanguageStorage languageStorage;
  final TokenStorage tokenStorage;
  final CategoriesStorage categoriesStorage;

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
    categoriesStorage.categories.clear();
    return languageStorage.isLanguageSelection.set(selection);
  }

  @override
  Future<void> setLanguage(String languageName) {
    return languageStorage.languageName.set(languageName);
  }

  @override
  Future<void> setLogin(bool isLogin) {
    return tokenStorage.isLogin.set(isLogin);
  }

  @override
  Future<bool?> isLogin() async {
    return tokenStorage.isLogin.call();
  }

  @override
  Future<void> clear() async {
    await tokenStorage.isLogin.clear();
    await tokenStorage.token.clear();
  }
}

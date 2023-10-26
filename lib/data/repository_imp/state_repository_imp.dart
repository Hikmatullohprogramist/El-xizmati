import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/storage/language_storage.dart';
import 'package:onlinebozor/data/storage/token_storage.dart';

import '../../domain/repository/state_repository.dart';

@LazySingleton(as: StateRepository)
class StateRepositoryImp extends StateRepository {
  StateRepositoryImp(this.languageStorage, this.tokenStorage);

  final LanguageStorage languageStorage;
  final TokenStorage tokenStorage;

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

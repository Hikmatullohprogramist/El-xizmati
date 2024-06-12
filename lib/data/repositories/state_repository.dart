import 'package:onlinebozor/data/datasource/floor/dao/category_entity_dao.dart';
import 'package:onlinebozor/data/datasource/preference/language_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/auth_preferences.dart';
import 'package:onlinebozor/domain/models/language/language.dart';

// @LazySingleton()
class StateRepository {
  final CategoryEntityDao _categoryEntityDao;
  final LanguagePreferences _languagePreferences;
  final AuthPreferences _tokenPreferences;

  StateRepository(
    this._categoryEntityDao,
    this._languagePreferences,
    this._tokenPreferences,
  );

  Language getLanguage()  {
    return _languagePreferences.language;
  }

  bool isLanguageSelection() {
    return _languagePreferences.isLanguageSelected;
  }

  Future<void> setLanguage(Language language) async {
    await _categoryEntityDao.clear();

    return _languagePreferences.setLanguage(language);
  }

  Future<void> setLogin(bool isLogin) {
    return _tokenPreferences.setIsAuthorized(isLogin);
  }

  bool isAuthorized() {
    return _tokenPreferences.isAuthorized;
  }

  bool isNotAuthorized() {
    return !_tokenPreferences.isAuthorized;
  }

  Future<void> clear() async {
    await _tokenPreferences.clear();
  }
}

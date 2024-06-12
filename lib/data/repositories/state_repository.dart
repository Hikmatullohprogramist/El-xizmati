import 'package:onlinebozor/data/datasource/floor/dao/category_entity_dao.dart';
import 'package:onlinebozor/data/datasource/preference/language_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/auth_preferences.dart';
import 'package:onlinebozor/domain/models/language/language.dart';

class StateRepository {
  final AuthPreferences _authPreferences;
  final CategoryEntityDao _categoryEntityDao;
  final LanguagePreferences _languagePreferences;

  StateRepository(
    this._authPreferences,
    this._categoryEntityDao,
    this._languagePreferences,
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
    return _authPreferences.setIsAuthorized(isLogin);
  }

  bool isAuthorized() {
    return _authPreferences.isAuthorized;
  }

  bool isNotAuthorized() {
    return !_authPreferences.isAuthorized;
  }

  Future<void> clear() async {
    await _authPreferences.clear();
  }
}

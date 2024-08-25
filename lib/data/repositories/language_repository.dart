import 'package:El_xizmati/data/datasource/floor/dao/category_entity_dao.dart';
import 'package:El_xizmati/data/datasource/floor/dao/user_address_entity_dao.dart';
import 'package:El_xizmati/data/datasource/preference/language_preferences.dart';
import 'package:El_xizmati/domain/models/language/language.dart';

class LanguageRepository {
  final CategoryEntityDao _categoryEntityDao;
  final LanguagePreferences _languagePreferences;
  final UserAddressEntityDao _userAddressEntityDao;

  LanguageRepository(
    this._categoryEntityDao,
    this._languagePreferences,
    this._userAddressEntityDao,
  );

  Language getLanguage() {
    return _languagePreferences.language;
  }

  bool isLanguageSelected() {
    return _languagePreferences.isLanguageSelected;
  }

  Future<void> setLanguage(Language language) async {
    await _categoryEntityDao.clear();
    await _userAddressEntityDao.clear();

    return _languagePreferences.setLanguage(language);
  }
}

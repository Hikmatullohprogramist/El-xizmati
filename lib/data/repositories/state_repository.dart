import 'package:El_xizmati/data/datasource/preference/auth_preferences.dart';
import 'package:El_xizmati/data/datasource/preference/language_preferences.dart';

class StateRepository {
  final AuthPreferences _authPreferences;
  final LanguagePreferences _languagePreferences;

  StateRepository(
    this._authPreferences,
    this._languagePreferences,
  );

  bool isLanguageSelected() {
    return _languagePreferences.isLanguageSelected;
  }

  Future<void> setAuthorizingState(bool isAuthorized) {
    return _authPreferences.setIsAuthorized(isAuthorized);
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

abstract class StateRepository {
  Future<bool?> isLanguageSelection();

  Future<void> languageSelection(bool selection);

  Future<String?> getLanguageName();

  Future<void> setLanguage(String languageName);
}

import 'dart:ui';

enum Language {
  uzbekLatin,
  russian,
  uzbekCyrill;


  String getRestCode() {
    return switch (this) {
      Language.uzbekLatin => "la",
      Language.russian => "ru",
      Language.uzbekCyrill => "uz",
    };
  }

  Locale getLocale() {
    return switch (this) {
      Language.uzbekLatin => Locale('uz', 'UZ'),
      Language.russian => Locale('ru', 'RU'),
      Language.uzbekCyrill => Locale('uz', 'UZK'),
    };
  }

  static Language valueOrDefault(String? languageName) {
    return Language.values.firstWhere(
      (e) => e.name.toUpperCase() == languageName?.toUpperCase(),
      orElse: () => Language.uzbekLatin,
    );
  }
}

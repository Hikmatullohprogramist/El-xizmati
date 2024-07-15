enum Language {
  uzbekLatin,
  russian,
  uzbekCyrill;

  static Language valueOrDefault(String? languageName) {
    return Language.values.firstWhere(
      (e) => e.name.toUpperCase() == languageName?.toUpperCase(),
      orElse: () => Language.uzbekLatin,
    );
  }
}

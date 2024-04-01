import 'dart:ui';

import 'package:onlinebozor/domain/models/language/language.dart';

extension DistrictIdExts on List<int> {
  List<Map<String, int>> toMapList(String key) {
    return map((id) => {key: id}).toList();
  }
}

extension LanguageExts on Language {
  String getRestCode() {
    return switch (this) {
      Language.uzbekLatin => "la",
      Language.russian => "ru",
      Language.uzbekCyrill => "uz",
    };
  }
}

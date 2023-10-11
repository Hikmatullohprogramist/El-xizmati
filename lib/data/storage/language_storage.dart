import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../common/base/base_storage.dart';

@lazySingleton
class LanguageStorage {
  LanguageStorage(this._box);

  final Box _box;
  final String isLanguageKey = "is_language_selection_key";
  final String languageNameKey = "language_name_key";

  BaseStorage<bool> get isLanguageSelection =>
      BaseStorage(_box, key: isLanguageKey);

  BaseStorage<String> get languageName => BaseStorage(_box, key: languageNameKey);

  @FactoryMethod(preResolve: true)
  static Future<LanguageStorage> create() async {
    final box = await Hive.openBox('language_storage');
    return LanguageStorage(box);
  }
}

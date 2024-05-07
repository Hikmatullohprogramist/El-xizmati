import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/hive/core/box_value.dart';
import 'package:onlinebozor/domain/mappers/common_mapper_exts.dart';
import 'package:onlinebozor/domain/models/language/language.dart';

@lazySingleton
class LanguageStorage {
  LanguageStorage(this._box);

  static const String STORAGE_BOX_NAME = "language_storage";
  final String KEY_LANGUAGE = "string_language";

  final Box _box;

  @FactoryMethod(preResolve: true)
  static Future<LanguageStorage> create() async {
    final box = await Hive.openBox(STORAGE_BOX_NAME);
    return LanguageStorage(box);
  }

  BoxValue<String> get _languageBox => BoxValue(_box, key: KEY_LANGUAGE);

  bool get isLanguageSelected => _languageBox.getOrNull() != null;

  String get languageName =>
      _languageBox.getOrDefault(Language.uzbekLatin.name);

  Language get language => languageName.toLanguage();

  Future<void> setLanguage(Language language) =>
      _languageBox.set(language.name);

  Future<void> clear() async => await _languageBox.clear();
}

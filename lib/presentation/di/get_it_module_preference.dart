import 'package:get_it/get_it.dart';
import 'package:onlinebozor/data/datasource/preference/language_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/token_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/user_preferences.dart';

extension GetItModulePreference on GetIt {
  Future<void> preferencesModule() async {
    registerSingletonAsync(() async => await LanguagePreferences.create());

    registerSingletonAsync(() async => await TokenPreferences.create());

    registerSingletonAsync(() async => await UserPreferences.create());

    await allReady();
  }
}

import 'package:get_it/get_it.dart';
import 'package:onlinebozor/data/datasource/preference/language_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/token_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/user_preferences.dart';

extension GetItModulePreference on GetIt {
  Future<void> preferencesModule() async {
    registerSingletonAsync<LanguagePreferences>(
        () async => await LanguagePreferences.create());

    registerSingletonAsync<TokenPreferences>(
        () async => await TokenPreferences.create());

    registerSingletonAsync<UserPreferences>(
        () async => await UserPreferences.create());

    await allReady();
  }
}

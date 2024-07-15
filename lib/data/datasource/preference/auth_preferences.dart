import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/preference/preferences_extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPreferences {
  final SharedPreferences _preferences;

  AuthPreferences(this._preferences);

  static const String _keyAccessToken = "string_access_token";
  static const String _keyIsAuthorized = "bool_is_authorized";

  @factoryMethod
  static Future<AuthPreferences> create() async {
    final prefs = await SharedPreferences.getInstance();
    return AuthPreferences(prefs);
  }

  String get token => _preferences.getString(_keyAccessToken) ?? "";

  Future<void> setToken(String token) async =>
      await _preferences.setOrRemove(_keyAccessToken, token);

  bool get isAuthorized => _preferences.getBool(_keyIsAuthorized) ?? false;

  bool get isNotAuthorized => !isAuthorized;

  Future<void> setIsAuthorized(bool isAuthorized) async =>
      await _preferences.setOrRemove(_keyIsAuthorized, isAuthorized);

  Future<void> clear() async {
    await _preferences.remove(_keyAccessToken);
    await _preferences.remove(_keyIsAuthorized);
  }
}

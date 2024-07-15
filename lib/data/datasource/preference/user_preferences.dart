import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/datasource/network/responses/auth/login/login_response.dart';
import 'package:onlinebozor/data/datasource/preference/preferences_extensions.dart';
import 'package:shared_preferences/shared_preferences.dart';

// @lazySingleton
class UserPreferences {
  UserPreferences(this._preferences);

  final String _keyUserTin = "integer_user_tin";
  final String _keyUserPinfl = "integer_user_pinfl";
  final String _keyIsUserIdentified = "bool_is_user_identified";

  final SharedPreferences _preferences;

  @FactoryMethod(preResolve: true)
  static Future<UserPreferences> create() async {
    final prefs = await SharedPreferences.getInstance();
    return UserPreferences(prefs);
  }

  bool get isIdentified => _preferences.getBool(_keyIsUserIdentified) ?? false;

  bool get isNotIdentified => !isIdentified;

  int? get tin => _preferences.getInt(_keyUserTin);

  int? get pinfl => _preferences.getInt(_keyUserPinfl);

  int get tinOrPinfl => tin ?? pinfl ?? 0;

  Future<void> setIdentityState(bool? isIdentified) async =>
      await _preferences.setOrRemove(_keyIsUserIdentified, isIdentified);

  Future<void> setUserTin(int? tin) async =>
      await _preferences.setOrRemove(_keyUserTin, tin);

  Future<void> setUserPinfl(int? pinfl) async =>
      await _preferences.setOrRemove(_keyUserPinfl, pinfl);

  Future<void> setUserInfo(LoginUser? user) async {
    await _preferences.setOrRemove(_keyUserTin, user?.tin);
    await _preferences.setOrRemove(_keyUserPinfl, user?.pinfl);
    await _preferences.setOrRemove(_keyIsUserIdentified, user?.isRegistered);
  }

  Future<void> clear() async {
    await _preferences.remove(_keyUserTin);
    await _preferences.remove(_keyUserPinfl);
    await _preferences.remove(_keyIsUserIdentified);
  }
}

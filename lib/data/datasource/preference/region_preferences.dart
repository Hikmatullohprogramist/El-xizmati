import 'package:onlinebozor/domain/models/region_preference/region_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onlinebozor/data/datasource/preference/preferences_extensions.dart';
import 'package:injectable/injectable.dart';

class RegionPreferences {
  final SharedPreferences _preferences;

  RegionPreferences(this._preferences);

  static const String _regionId = 'region_id';
  static const String _regionName = 'region_name';
  static const String _districtId = 'district_id';
  static const String _districtName = 'district_name';

  @factoryMethod
  static Future<RegionPreferences> create() async {
    final prefs = await SharedPreferences.getInstance();
    return RegionPreferences(prefs);
  }

  int? get regionId => _preferences.getInt(_regionId);
  String? get regionName => _preferences.getString(_regionName);
  int? get districtId => _preferences.getInt(_districtId);
  String? get districtName => _preferences.getString(_districtName);

  String getRegionInfo(){
    if(isRegionSelected){
      return regionName! + districtName!;
    }
    return '';
  }

  bool get isRegionSelected => regionId != null && districtId != null;

  Future<void> setRegion(RegionPreference region) async {
    await _preferences.setInt(_regionId, region.regionId);
    await _preferences.setString(_regionName, region.regionName);
    await _preferences.setInt(_districtId, region.districtId);
    await _preferences.setString(_districtName, region.districtName);
  }

  Future<void> clear() async {
    await _preferences.remove(_regionId);
    await _preferences.remove(_regionName);
    await _preferences.remove(_districtId);
    await _preferences.remove(_districtName);
  }
}

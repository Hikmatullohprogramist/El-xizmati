import 'package:El_xizmati/data/datasource/network/responses/region/region_and_district_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/region/region_root_response.dart';
import 'package:El_xizmati/data/datasource/network/services/private/region_service.dart';
import 'package:El_xizmati/data/datasource/preference/region_preferences.dart';
import 'package:El_xizmati/domain/mappers/region_mapper.dart';
import 'package:El_xizmati/domain/models/district/district.dart';
import 'package:El_xizmati/domain/models/region/region.dart';
import 'package:El_xizmati/domain/models/region/region_and_district.dart';
import 'package:El_xizmati/domain/models/street/street.dart';

class RegionRepository {
  final RegionPreferences _regionPreferences;
  final RegionService _regionService;

  RegionRepository(
    this._regionPreferences,
    this._regionService,
  );

  Future<RegionAndDistrict> getRegionAndDistricts() async {
    final response = await _regionService.getRegionAndDistricts();
    final result = RegionAndDistrictRootResponse.fromJson(response.data).data;
    return result.toRegionAndDistrict();
  }

  Future<List<Region>> getRegions() async {
    final response = await _regionService.getRegions();
    final result = RegionRootResponse.fromJson(response.data).data;
    return result.map((e) => e.toRegion()).toList();
  }

  Future<List<District>> getDistricts(int regionId) async {
    final response = await _regionService.getDistricts(regionId);
    final result = RegionRootResponse.fromJson(response.data).data;
    return result.map((e) => e.toDistrict(regionId)).toList();
  }

  Future<List<Neighborhood>> getNeighborhoods(int streetId) async {
    final response = await _regionService.getNeighborhoods(streetId);
    final result = RegionRootResponse.fromJson(response.data).data;
    return result.map((e) => e.toNeighborhood()).toList();
  }

  Future<void> setSelectedRegion(int regionId, String regionName,
      int districtId, String districtName) async {
    return _regionPreferences.setSelectedRegion(
        regionId: regionId,
        regionName: regionName,
        districtId: districtId,
        districtName: districtName,);
  }

  String? getSelectedRegionName() {
    return _regionPreferences.selectedRegionName;
  }

  int? getSelectedRegionId() {
    return _regionPreferences.regionId;
  }

  int? getSelectedDistrictId() {
    return _regionPreferences.districtId;
  }

  Future<void> clearSelectedRegion() {
    return _regionPreferences.clear();
  }

  Future<void> setIntroRegionSelection() {
    return _regionPreferences.setDefaultRegionSelection;
  }
}

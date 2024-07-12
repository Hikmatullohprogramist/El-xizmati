import 'package:onlinebozor/data/datasource/network/responses/region/region_and_district_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/region/region_root_response.dart';
import 'package:onlinebozor/data/datasource/network/services/private/region_service.dart';
import 'package:onlinebozor/domain/mappers/region_mapper.dart';
import 'package:onlinebozor/domain/models/district/district.dart';
import 'package:onlinebozor/domain/models/region/region.dart';
import 'package:onlinebozor/domain/models/region/region_and_district.dart';
import 'package:onlinebozor/domain/models/street/street.dart';

class RegionRepository {
  final RegionService _regionService;

  RegionRepository(
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
}

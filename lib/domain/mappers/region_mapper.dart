import 'package:onlinebozor/data/datasource/network/responses/region/district_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/region/region_and_district_response.dart';
import 'package:onlinebozor/data/datasource/network/responses/region/region_response.dart';
import 'package:onlinebozor/domain/models/district/district.dart';
import 'package:onlinebozor/domain/models/list/expandable_list_item.dart';
import 'package:onlinebozor/domain/models/region/region.dart';
import 'package:onlinebozor/domain/models/region/region_and_district.dart';
import 'package:onlinebozor/domain/models/street/street.dart';

extension RegionResponseExts on RegionResponse {
  Region toRegion() {
    return Region(id: id, name: name);
  }

  District toDistrict(int regionId) {
    return District(id: id, name: name, regionId: id);
  }

  Neighborhood toNeighborhood() {
    return Neighborhood(id: id, name: name);
  }
}

extension DistrictResponseExts on DistrictResponse {
  District toDistrict() {
    return District(id: id, name: name, regionId: reg_id);
  }
}

extension RegionItemExts on ExpandableListItem {
  District toDistrict() {
    return District(
      id: id,
      regionId: parentId,
      name: name,
    );
  }
}

extension RegionAndDistrictExts on RegionAndDistrictResponse {
  RegionAndDistrict toMap() {
    return RegionAndDistrict(
      regions: regions.map((e) => e.toRegion()).toList(),
      districts: districts.map((e) => e.toDistrict()).toList(),
    );
  }
}

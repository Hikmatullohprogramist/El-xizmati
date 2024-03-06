import 'package:onlinebozor/data/responses/region/district_response.dart';
import 'package:onlinebozor/data/responses/region/region_and_district_response.dart';
import 'package:onlinebozor/domain/models/district/district.dart';
import 'package:onlinebozor/domain/models/region/region.dart';
import 'package:onlinebozor/domain/models/region/region_and_district.dart';
import 'package:onlinebozor/domain/models/region/region_item.dart';
import 'package:onlinebozor/domain/models/street/street.dart';

import '../../data/responses/region/region_response.dart';

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

extension RegionExts on Region {
  RegionItem toRegionItem({bool isSelected = false, bool isVisible = false}) {
    return RegionItem(
      id: id,
      parentId: 0,
      name: name,
      isParent: true,
      isSelected: isSelected,
      isVisible: isVisible,
    );
  }
}

extension DistrictResponseExts on DistrictResponse {
  District toDistrict() {
    return District(id: id, name: name, regionId: reg_id);
  }
}

extension DistrictExts on District {
  RegionItem toRegionItem({bool isSelected = false, bool isVisible = false}) {
    return RegionItem(
      id: id,
      parentId: regionId,
      name: name,
      isParent: false,
      isSelected: isSelected,
      isVisible: isVisible,
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

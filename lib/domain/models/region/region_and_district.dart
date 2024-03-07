import 'package:onlinebozor/domain/models/district/district.dart';
import 'package:onlinebozor/domain/models/region/region.dart';

class RegionAndDistrict {
  RegionAndDistrict({
    required this.regions,
    required this.districts,
  });

  List<Region> regions;
  List<District> districts;
}

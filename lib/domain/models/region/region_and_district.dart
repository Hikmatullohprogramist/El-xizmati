import 'package:El_xizmati/domain/models/district/district.dart';
import 'package:El_xizmati/domain/models/region/region.dart';

class RegionAndDistrict {
  RegionAndDistrict({
    required this.regions,
    required this.districts,
  });

  List<Region> regions;
  List<District> districts;
}

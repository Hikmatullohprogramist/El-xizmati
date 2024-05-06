import 'package:hive/hive.dart';

part 'user_address_hive_object.g.dart';

@HiveType(typeId: 1)
class UserAddressHiveObject {
  UserAddressHiveObject({
    required this.id,
    required this.name,
    required this.regionId,
    required this.regionName,
    required this.districtId,
    required this.districtName,
    required this.neighborhoodId,
    required this.neighborhoodName,
    required this.streetName,
    required this.homeNumber,
    required this.apartmentNumber,
    required this.state,
    required this.isMain,
    required this.geo,
  });

  @HiveField(1)
  int id;

  @HiveField(2)
  String name;

  @HiveField(3)
  int regionId;

  @HiveField(4)
  String regionName;

  @HiveField(5)
  int districtId;

  @HiveField(6)
  String districtName;

  @HiveField(7)
  int neighborhoodId;

  @HiveField(8)
  String neighborhoodName;

  @HiveField(9)
  String streetName;

  @HiveField(10)
  String homeNumber;

  @HiveField(11)
  String apartmentNumber;

  @HiveField(12)
  int state;

  @HiveField(13)
  bool isMain;

  @HiveField(14)
  String geo;
}

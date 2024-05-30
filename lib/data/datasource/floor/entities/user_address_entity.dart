import 'package:floor/floor.dart';

@Entity(tableName: "user_addresses")
class UserAddressEntity {
  @primaryKey
  @ColumnInfo(name: "user_address_id")
  int id;

  @ColumnInfo(name: "user_address_name")
  String name;

  @ColumnInfo(name: "user_address_region_id")
  int regionId;

  @ColumnInfo(name: "user_address_region_name")
  String regionName;

  @ColumnInfo(name: "user_address_district_id")
  int districtId;

  @ColumnInfo(name: "user_address_district_name")
  String districtName;

  @ColumnInfo(name: "user_address_neighborhood_id")
  int neighborhoodId;

  @ColumnInfo(name: "user_address_neighborhood_name")
  String neighborhoodName;

  @ColumnInfo(name: "user_address_street_name")
  String streetName;

  @ColumnInfo(name: "user_address_house_number")
  String houseNumber;

  @ColumnInfo(name: "user_address_apartment_number")
  String apartmentNumber;

  @ColumnInfo(name: "user_address_state")
  int state;

  @ColumnInfo(name: "user_address_is_main")
  bool isMain;

  @ColumnInfo(name: "user_address_geo")
  String geo;

  UserAddressEntity({
    required this.id,
    required this.name,
    required this.regionId,
    required this.regionName,
    required this.districtId,
    required this.districtName,
    required this.neighborhoodId,
    required this.neighborhoodName,
    required this.streetName,
    required this.houseNumber,
    required this.apartmentNumber,
    required this.state,
    required this.isMain,
    required this.geo,
  });
}

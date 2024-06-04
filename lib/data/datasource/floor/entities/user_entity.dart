import 'package:floor/floor.dart';

@Entity(tableName: "users")
class UserEntity {

  @primaryKey
  @ColumnInfo(name: "user_id")
  int id;

  @ColumnInfo(name: "user_full_name")
  String fullName;

  @ColumnInfo(name: "user_pinfl")
  int? pinfl;

  @ColumnInfo(name: "user_tin")
  int? tin;

  @ColumnInfo(name: "user_gender")
  String? gender;

  @ColumnInfo(name: "user_doc_serial")
  String? docSerial;

  @ColumnInfo(name: "user_doc_number")
  String? docNumber;

  @ColumnInfo(name: "user_region_id")
  int? regionId;

  @ColumnInfo(name: "user_region_name")
  String regionName;

  @ColumnInfo(name: "user_district_id")
  int? districtId;

  @ColumnInfo(name: "user_district_name")
  String districtName;

  @ColumnInfo(name: "user_neighborhood_id")
  int? neighborhoodId;

  @ColumnInfo(name: "user_neighborhood_name")
  String neighborhoodName;

  @ColumnInfo(name: "user_house_number")
  String? houseNumber;

  @ColumnInfo(name: "user_apartment_name")
  String? apartmentName;

  @ColumnInfo(name: "user_birth_date")
  String birthDate;

  @ColumnInfo(name: "user_photo")
  String photo;

  @ColumnInfo(name: "user_email")
  String email;

  @ColumnInfo(name: "user_phone")
  String phone;

  @ColumnInfo(name: "user_notification_sources")
  String notificationSource;

  @ColumnInfo(name: "user_is_identified")
  bool isIdentified;

  @ColumnInfo(name: "user_state")
  int? state;

  UserEntity({
    required this.id,
    required this.fullName,
    required this.pinfl,
    required this.tin,
    required this.gender,
    required this.docSerial,
    required this.docNumber,
    required this.regionId,
    required this.regionName,
    required this.districtId,
    required this.districtName,
    required this.neighborhoodId,
    required this.neighborhoodName,
    required this.houseNumber,
    required this.apartmentName,
    required this.birthDate,
    required this.photo,
    required this.email,
    required this.phone,
    required this.notificationSource,
    required this.isIdentified,
    required this.state,
  });
}

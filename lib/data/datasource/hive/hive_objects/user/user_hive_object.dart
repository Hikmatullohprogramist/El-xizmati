import 'package:hive/hive.dart';
import 'package:onlinebozor/data/datasource/hive/constants/hive_constants.dart';

part 'user_hive_object.g.dart';

@HiveType(typeId: HiveConstants.USER_TYPE_ID)
class UserHiveObject extends HiveObject {
  UserHiveObject({
    this.id,
    this.pinfl,
    this.gender,
    this.passportNumber,
    this.passportSerial,
    this.tin,
    this.homeName,
    this.regionId,
    this.regionName,
    this.neighborhoodId,
    this.districtName,
    this.birthDate,
    this.photo,
    this.isIdentityVerified,
    this.eimzoAllowToLogin,
    this.postName,
    this.state,
    this.email,
    this.isPassword,
    this.fullName,
    this.districtId,
    this.areaName,
    this.apartmentName,
    this.mobilePhone,
    this.oblName,
    this.username,
  });

  @HiveField(1)
  int? id;

  @HiveField(2)
  int? pinfl;

  @HiveField(3)
  String? gender;

  @HiveField(4)
  String? passportNumber;

  @HiveField(5)
  String? passportSerial;

  @HiveField(6)
  int? tin;

  @HiveField(7)
  String? homeName;

  @HiveField(8)
  int? regionId;

  @HiveField(9)
  String? regionName;

  @HiveField(10)
  int? neighborhoodId;

  @HiveField(11)
  String? districtName;

  @HiveField(12)
  String? birthDate;

  @HiveField(13)
  String? photo;

  @HiveField(14)
  bool? isIdentityVerified;

  @HiveField(15)
  String? eimzoAllowToLogin;

  @HiveField(16)
  String? postName;

  @HiveField(17)
  int? state;

  @HiveField(18)
  String? email;

  @HiveField(19)
  bool? isPassword;

  @HiveField(20)
  String? fullName;

  @HiveField(22)
  int? districtId;

  @HiveField(23)
  String? areaName;

  @HiveField(24)
  String? apartmentName;

  @HiveField(25)
  String? mobilePhone;

  @HiveField(27)
  String? oblName;

  @HiveField(28)
  String? username;
}

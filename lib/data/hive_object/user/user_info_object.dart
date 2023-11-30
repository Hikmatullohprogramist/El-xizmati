import 'package:hive/hive.dart';

part 'user_info_object.g.dart';

@HiveType(typeId: 4)
class UserInfoObject extends HiveObject {
  UserInfoObject(
      {this.id,
      this.pinfl,
      this.gender,
      this.passportNumber,
      this.passportSerial,
      this.tin,
      this.homeName,
      this.regionId,
      this.regionName,
      this.districtId,
      this.districtName,
      this.birthDate,
      this.photo,
      this.isRegistered,
      this.eimzoAllowToLogin,
      this.postName,
      this.state,
      this.email,
      this.isPassword,
      this.fullName,
      this.registeredWithEimzo,
      this.areaId,
      this.areaName,
      this.apartmentName,
      this.mobilePhone,
      this.oblId,
      this.oblName,
      this.username});

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
  int? districtId;

  @HiveField(11)
  String? districtName;

  @HiveField(12)
  String? birthDate;

  @HiveField(13)
  String? photo;

  @HiveField(14)
  bool? isRegistered;

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

  @HiveField(21)
  String? registeredWithEimzo;

  @HiveField(22)
  int? areaId;

  @HiveField(23)
  String? areaName;

  @HiveField(24)
  String? apartmentName;

  @HiveField(25)
  String? mobilePhone;

  @HiveField(26)
  int? oblId;

  @HiveField(27)
  String? oblName;

  @HiveField(28)
  String? username;
}

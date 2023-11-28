import 'package:hive/hive.dart';

part 'profile_hive_object.g.dart';

@HiveType(typeId: 4)
class ProfileHiveObject extends HiveObject {
  ProfileHiveObject(
      {required this.id,
      required this.photo,
      required this.username,
      required this.districtId,
      required this.fullName,
      required this.regionId,
      required this.postName,
      required this.email,
      required this.gender,
      required this.telegramId,
      required this.messageType,
      required this.pinfl,
      required this.tin,
      required this.mahallaId,
      required this.homeName,
      required this.passportNumber,
      required this.passportSerial,
      required this.isRegistered,
      required this.birthDate,
      required this.typeActivity,
      required this.mobilePhone});

  @HiveField(1)
  int id;
  @HiveField(2)
  String photo;
  @HiveField(3)
  String username;
  @HiveField(4)
  int districtId;
  @HiveField(5)
  String fullName;
  @HiveField(6)
  int regionId;
  @HiveField(7)
  int postName;
  @HiveField(8)
  String email;
  @HiveField(9)
  String gender;
  @HiveField(10)
  int telegramId;
  @HiveField(11)
  int messageType;
  @HiveField(12)
  String pinfl;
  @HiveField(13)
  int tin;
  @HiveField(14)
  int mahallaId;
  @HiveField(15)
  String homeName;
  @HiveField(16)
  int passportNumber;
  @HiveField(17)
  String passportSerial;
  @HiveField(18)
  bool isRegistered;
  @HiveField(19)
  String birthDate;
  @HiveField(20)
  int typeActivity;
  @HiveField(21)
  int mobilePhone;
}

//  data: {
//      id: 53895,
//      photo: null,
//      username: "998975705616",
//      district_id: null,
//      full_name: null,
//      region_id: null,
//      post_name: null,
//      email: null,
//      gender: "UNKNOWN",
//      telegram_id: null,
//      message_type: null,
//      pinfl: null,
//      tin: null,
//      mahalla_id: null,
//      home_name: null,
//      passport_number: null,
//      passport_serial: null,
//      is_registered: false,
//      birth_date: null,
//      type_activity: "PHYSICAL",
//      mobile_phone: "998975705616",
//      actives: [
//         {
//              id: 18838,
//              token: "a7af6c33-677b-4094-8ac6-5339ac694612",
//              last_activity_at: "24.11.2023 02:11:28",
//              last_login_at: "24.11.2023 02:11:28",
//              "17360ab6-91e8-5932-b1ed-533a6ad6f3c7&&Android SDK built for x86&&unkn
//              own Android SDK built for x86&&APPLICATION"
//              user_id: 53895,
//              last_ip_address: "80.80.222.241"
//         },
//         {
//              id: 18796,
//              token: "63514b36-6f3e-40b1-8961-d81aa1147ec8",
//              last_activity_at: "27.11.2023 06:11:40",
//              last_login_at: "27.11.2023 06:11:40",
//              user_agent: "Apache-HttpClient/4.5.2 (Java/17.0.5)",
//              user_id: 53895,
//              last_ip_address: "80.80.222.241"
//         },
//         {
//              id: 18679,
//              token: "cc3fd145-5e95-4f18-a090-cc5f3c428dfa",
//              last_activity_at: "27.11.2023 06:11:40",
//              last_login_at: "27.11.2023 06:11:40",
//              "32d2e6fe-fa93-59d0-8452-5fa184678eee&&SM-G996N&&samsung SM-G996N&&APP
//              LICATION"
//              user_id: 53895,
//              last_ip_address: "80.80.222.241"
//         }
//      ],
//      socials: []
// }

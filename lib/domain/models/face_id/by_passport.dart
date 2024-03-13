// To parse this JSON data, do
//
//     final byPassportModel = byPassportModelFromJson(jsonString);

import 'dart:convert';

ByPassportModel byPassportModelFromJson(String str) => ByPassportModel.fromJson(json.decode(str));

String byPassportModelToJson(ByPassportModel data) => json.encode(data.toJson());

class ByPassportModel {
  String passportSerial;
  String passportNumber;
    String birthDate;

  ByPassportModel({
    required this.passportSerial,
    required this.passportNumber,
    required this.birthDate,
  });

  factory ByPassportModel.fromJson(Map<String, dynamic> json) => ByPassportModel(
    passportSerial: json["passport_serial"],
    passportNumber: json["passport_number"],
    birthDate:json["birth_date"],
  );

  Map<String, dynamic> toJson() => {
    "passport_serial": passportSerial,
    "passport_number": passportNumber,
    "birth_date": birthDate,
  };
}

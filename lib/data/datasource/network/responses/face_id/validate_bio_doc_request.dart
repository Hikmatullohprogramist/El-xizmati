// // To parse this JSON data, do
// //
// //     final byPassportModel = byPassportModelFromJson(jsonString);
//
// import 'dart:convert';
//
// ValidateBioDocRequest validateBioDocRequestFromJson(String str) =>
//     ValidateBioDocRequest.fromJson(json.decode(str));
//
// String validateBioDocRequestToJson(ValidateBioDocRequest data) =>
//     json.encode(data.toJson());
//
// class ValidateBioDocRequest {
//   String bioDocSerial;
//   String bioDocNumber;
//   String birthDate;
//
//   ValidateBioDocRequest({
//     required this.bioDocSerial,
//     required this.bioDocNumber,
//     required this.birthDate,
//   });
//
//   factory ValidateBioDocRequest.fromJson(Map<String, dynamic> json) =>
//       ValidateBioDocRequest(
//         bioDocSerial: json["passport_serial"],
//         bioDocNumber: json["passport_number"],
//         birthDate: json["birth_date"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "passport_serial": bioDocSerial,
//         "passport_number": bioDocNumber,
//         "birth_date": birthDate,
//       };
// }
import 'package:freezed_annotation/freezed_annotation.dart';

part 'validate_bio_doc_request.freezed.dart';
part 'validate_bio_doc_request.g.dart';

@freezed
class ValidateBioDocRequest with _$ValidateBioDocRequest {
  const factory ValidateBioDocRequest({
    required String passport_serial,
    required String passport_number,
    required String birth_date,
  }) = _ValidateBioDocRequest;

  factory ValidateBioDocRequest.fromJson(Map<String, dynamic> json) =>
      _$ValidateBioDocRequestFromJson(json);
}

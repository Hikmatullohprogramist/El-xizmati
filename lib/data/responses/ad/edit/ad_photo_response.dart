import 'package:freezed_annotation/freezed_annotation.dart';

part 'ad_photo_response.freezed.dart';
part 'ad_photo_response.g.dart';

@freezed
class AdPhotoResponse with _$AdPhotoResponse {
  const factory AdPhotoResponse({
    required String image,
    required bool? isMain,
  }) = _AdPhotoResponse;

  factory AdPhotoResponse.fromJson(Map<String, dynamic> json) =>
      _$AdPhotoResponseFromJson(json);
}

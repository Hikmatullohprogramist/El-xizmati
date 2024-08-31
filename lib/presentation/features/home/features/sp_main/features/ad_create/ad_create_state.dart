part of 'ad_create_cubit.dart';

@freezed
class AdCreateState with _$AdCreateState {
  const factory AdCreateState({
    @Default(null) UploadableFile? image,
    @Default(false) bool isScrolling,
    @Default("") String category,
    @Default("") String description,
    @Default("") String price,
    @Default(null) Point? location,
    @Default("") String country,
    @Default("") String region,
    @Default("") String district,
    @Default("") String type,
    @Default("") String payment_type,
  }) = _AdCreateState;
}

@freezed
class AdCreateEvent with _$AdCreateEvent {
  const factory AdCreateEvent() = _AdCreateEvent;
}

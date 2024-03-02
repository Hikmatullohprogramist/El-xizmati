part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(false) bool isEditing,
    int? addressId,
    UserAddressResponse? address,
    @Default([]) List<RegionResponse> regions,
    @Default([]) List<RegionResponse> districts,
    @Default([]) List<RegionResponse> neighborhoods,
    String? addressName,
    int? regionId,
    String? regionName,
    int? districtId,
    String? districtName,
    int? neighborhoodId,
    String? neighborhoodName,
    String? streetName,
    String? homeNumber,
    String? apartmentNum,
    bool? isMain,
    double? latitude,
    double? longitude,
    String? geo,
    String? state,
    @Default(false) bool isLoading,
    @Default(false) bool isLocationLoading,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType type) = _PageEvent;
}

enum PageEventType { onStartLoading, onFinishLoading, backOnSuccess }

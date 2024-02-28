part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    String? addressName,
    int? regionId,
    String? regionName,
    int? districtId,
    String? districtName,
    int? streetId,
    String? streetName,
    String? homeNumber,
    String? apartmentNum,
    String? neighborhoodNum,
    UserAddressResponse? address,
    @Default(<RegionResponse>[]) List<RegionResponse> regions,
    @Default(<RegionResponse>[]) List<RegionResponse> districts,
    @Default(<RegionResponse>[]) List<RegionResponse> streets,
    bool? isMain,
    double? latitude,
    double? longitude,
    String? geo,
    String? flat,
    String? state,
    int? addressId,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType type) = _PageEvent;
}

enum PageEventType { navigationToHome }

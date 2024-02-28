part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    PagingController<int, ActiveDeviceResponse>? controller,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}

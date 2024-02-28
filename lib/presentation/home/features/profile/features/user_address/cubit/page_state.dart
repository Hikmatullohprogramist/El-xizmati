part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(LoadingState.loading) LoadingState loadState,
    PagingController<int, UserAddressResponse>? controller,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(
    PageEventType effect, {
    String? error,
    UserAddressResponse? address,
  }) = _PageEvent;
}

enum PageEventType { success, editUserAddress }

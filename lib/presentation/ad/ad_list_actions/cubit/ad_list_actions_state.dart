part of 'ad_list_actions_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    UserAdResponse? userAdResponse,
    UserAdStatus? userAdStatus,
    @Default(true) bool isEditEnabled,
    @Default(true) bool isAdvertiseEnabled,
    @Default(true) bool isActivateEnabled,
    @Default(true) bool isDeactivateEnabled,
    @Default(true) bool isDeleteEnabled,
    @Default(LoadingState.loading) LoadingState actionLoadState,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType type) = _PageEvent;
}

enum PageEventType { closeOnSuccess }

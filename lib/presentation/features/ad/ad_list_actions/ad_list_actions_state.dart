part of 'ad_list_actions_cubit.dart';

@freezed
class AdListActionsState with _$AdListActionsState {
  const factory AdListActionsState({
    UserAdResponse? userAdResponse,
    UserAdStatus? userAdStatus,
    @Default(true) bool isEditEnabled,
    @Default(true) bool isAdvertiseEnabled,
    @Default(true) bool isActivateEnabled,
    @Default(true) bool isDeactivateEnabled,
    @Default(true) bool isDeleteEnabled,
    @Default(LoadingState.loading) LoadingState actionLoadState,
  }) = _AdListActionsState;
}

@freezed
class AdListActionsEvent with _$AdListActionsEvent {
  const factory AdListActionsEvent(AdListActionsEventType type) = _AdListActionsEvent;
}

enum AdListActionsEventType { closeOnSuccess }

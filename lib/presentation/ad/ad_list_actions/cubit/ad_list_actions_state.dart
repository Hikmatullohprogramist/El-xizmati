part of 'ad_list_actions_cubit.dart';

@freezed
class AdListActionsBuildable with _$AdListActionsBuildable {
  const factory AdListActionsBuildable({
    UserAdResponse? userAdResponse,
    UserAdStatus? userAdStatus,
    @Default(true) bool isEditEnabled,
    @Default(true) bool isAdvertiseEnabled,
    @Default(true) bool isActivateEnabled,
    @Default(true) bool isDeactivateEnabled,
    @Default(true) bool isDeleteEnabled,
    @Default(LoadingState.loading) LoadingState actionLoadState,
  }) = _AdListActionsBuildable;
}

@freezed
class AdListActionsListenable with _$AdListActionsListenable {
  const factory AdListActionsListenable(
    AdListActionsEvent eventData,
  ) = _AdListActionsListenable;
}

enum AdListActionsEvent { closeOnSuccess }

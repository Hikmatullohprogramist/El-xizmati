part of 'user_inactive_ads_cubit.dart';

@freezed
class UserInactiveAdsBuildable with _$UserInactiveAdsBuildable {
  const factory UserInactiveAdsBuildable({
    @Default("") String keyWord,
    @Default(AppLoadingState.loading) AppLoadingState userAdsState,
    PagingController<int, UserAdResponse>? userAdsPagingController,
  }) = _UserInactiveAdsBuildable;
}

@freezed
class UserInactiveAdsListenable with _$UserInactiveAdsListenable {
  const factory UserInactiveAdsListenable() = _UserInactiveAdsListenable;
}
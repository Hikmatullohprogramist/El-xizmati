part of 'user_pending_ads_cubit.dart';

@freezed
class UserPendingAdsBuildable with _$UserPendingAdsBuildable {
  const factory UserPendingAdsBuildable({
    @Default("") String keyWord,
    @Default(AppLoadingState.loading) AppLoadingState userAdsState,
    PagingController<int, UserAdResponse>? userAdsPagingController,
  }) = _UserPendingAdsBuildable;
}

@freezed
class UserPendingAdsListenable with _$UserPendingAdsListenable {
  const factory UserPendingAdsListenable() = _UserPendingAdsListenable;
}
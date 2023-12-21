part of 'user_cancel_ads_cubit.dart';

@freezed
class UserCancelAdsBuildable with _$UserCancelAdsBuildable {
  const factory UserCancelAdsBuildable({
    @Default("") String keyWord,
    @Default(AppLoadingState.loading) AppLoadingState userAdsState,
    PagingController<int, UserAdResponse>? userAdsPagingController,
  }) = _UserCancelAdsBuildable;
}

@freezed
class UserCancelAdsListenable with _$UserCancelAdsListenable {
  const factory UserCancelAdsListenable() = _UserCancelAdsListenable;
}

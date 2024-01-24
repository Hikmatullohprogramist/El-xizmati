part of 'user_all_ads_cubit.dart';

@freezed
class UserAllAdsBuildable with _$UserAllAdsBuildable {
  const factory UserAllAdsBuildable({
    @Default("") String keyWord,
    @Default(LoadingState.loading) LoadingState userAdsState,
    PagingController<int, UserAdResponse>? userAdsPagingController,
  }) = _UserAllAdsBuildable;
}

@freezed
class UserAllAdsListenable with _$UserAllAdsListenable {
  const factory UserAllAdsListenable() = _UserAllAdsListenable;
}

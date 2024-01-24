part of 'user_active_ads_cubit.dart';

@freezed
class UserActiveAdsBuildable with _$UserActiveAdsBuildable {
  const factory UserActiveAdsBuildable({
    @Default("") String keyWord,
    @Default(LoadingState.loading) LoadingState userAdsState,
    PagingController<int, UserAdResponse>? userAdsPagingController,
  }) = _UserActiveAdsBuildable;
}

@freezed
class UserActiveAdsListenable with _$UserActiveAdsListenable {
  const factory UserActiveAdsListenable() = _UserActiveAdsListenable;
}
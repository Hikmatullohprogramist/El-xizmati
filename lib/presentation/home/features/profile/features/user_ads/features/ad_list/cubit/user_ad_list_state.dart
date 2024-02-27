part of 'user_ad_list_cubit.dart';

@freezed
class UserAdListBuildable with _$UserAdListBuildable {
  const factory UserAdListBuildable({
    @Default("") String keyWord,
    @Default(UserAdStatus.all) UserAdStatus userAdStatus,
    @Default(LoadingState.loading) LoadingState userAdsState,
    PagingController<int, UserAdResponse>? userAdsPagingController,
  }) = _UserAdListBuildable;
}

@freezed
class UserAdListListenable with _$UserAdListListenable {
  const factory UserAdListListenable() = _UserAdListListenable;
}

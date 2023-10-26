part of 'ad_list_cubit.dart';

@freezed
class AdListBuildable with _$AdListBuildable {
  const factory AdListBuildable({
    @Default("") String keyWord,
    @Default(AdListType.LIST) AdListType adListType,
    @Default(AppLoadingState.LOADING) AppLoadingState adsState,
    PagingController<int, AdResponse>? adsPagingController,
  }) = _AdListBuildable;
}

@freezed
class AdListListenable with _$AdListListenable {
  const factory AdListListenable(AdListEffect effect, {String? message}) =
      _AdListListenable;
}

enum AdListEffect { success }

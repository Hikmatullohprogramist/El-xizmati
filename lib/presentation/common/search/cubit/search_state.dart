part of 'search_cubit.dart';

@freezed
class SearchBuildable with _$SearchBuildable {
  const factory SearchBuildable(
      {@Default(AppLoadingState.onStart) AppLoadingState appLoadingState,
      @Default(<Ad>[]) List<Ad> searchResult}) =
      _SearchBuildable;
}

@freezed
class SearchListenable with _$SearchListenable {
  const factory SearchListenable() = _SearchListenable;
}

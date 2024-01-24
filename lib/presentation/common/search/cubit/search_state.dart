part of 'search_cubit.dart';

@freezed
class SearchBuildable with _$SearchBuildable {
  const factory SearchBuildable(
          {@Default(LoadingState.onStart) LoadingState appLoadingState,
          @Default(<AdSearchResponse>[]) List<AdSearchResponse> searchResult}) =
      _SearchBuildable;
}

@freezed
class SearchListenable with _$SearchListenable {
  const factory SearchListenable() = _SearchListenable;
}

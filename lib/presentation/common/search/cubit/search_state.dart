part of 'search_cubit.dart';

@freezed
class SearchBuildable with _$SearchBuildable {
  const factory SearchBuildable(
          {@Default(AppLoadingState.onStart) AppLoadingState appLoadingState,
          @Default(<AdSearchResponse>[]) List<AdSearchResponse> searchResult}) =
      _SearchBuildable;
}

@freezed
class SearchListenable with _$SearchListenable {
  const factory SearchListenable() = _SearchListenable;
}

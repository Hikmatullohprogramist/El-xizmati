part of 'favorites_cubit.dart';

@freezed
class FavoritesBuildable with _$FavoritesBuildable {
  const factory FavoritesBuildable() = _FavoritesBuildable;
}

@freezed
class FavoritesListenable with _$FavoritesListenable {
  const factory FavoritesListenable(FavoritesEffect effect, {String? message}) =
      _FavoritesListenable;
}

enum FavoritesEffect { success }

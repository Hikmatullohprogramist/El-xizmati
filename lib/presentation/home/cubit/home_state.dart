part of 'home_cubit.dart';

@freezed
class HomeBuildable with _$HomeBuildable {
  const factory HomeBuildable({
    @Default(false) bool isLogin,
    @Default(0) int cartAmount,
    @Default(0) int favoriteAmount,
  }) = _HomeBuildable;
}

@freezed
class HomeListenable with _$HomeListenable {
  const factory HomeListenable() = _HomeListenable;
}

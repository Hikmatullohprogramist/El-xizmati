part of 'home_cubit.dart';

@freezed
class HomeBuildable with _$HomeBuildable {
  const factory HomeBuildable({@Default(false) bool isLogin}) = _HomeBuildable;
}

@freezed
class HomeListenable with _$HomeListenable {
  const factory HomeListenable() = _HomeListenable;
}

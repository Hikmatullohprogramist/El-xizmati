part of 'a_cubit.dart';

@freezed
class ZZBuildable with _$ZZBuildable {
  const factory ZZBuildable() = _ZZBuildable;
}

@freezed
class ZZListenable with _$ZZListenable {
  const factory ZZListenable({ZZEffect? zzEffect}) = _ZZListenable;
}

enum ZZEffect{success}

part of 'create_ad_start_cubit.dart';

@freezed
class CreateAdStartBuildable with _$CreateAdStartBuildable {
  const factory CreateAdStartBuildable() = _CreateAdStartBuildable;
}

@freezed
class CreateAdStartListenable with _$CreateAdStartListenable {
  const factory CreateAdStartListenable({CreateAdStartEffect? zzEffect}) = _CreateAdStartListenable;
}

enum CreateAdStartEffect{success}

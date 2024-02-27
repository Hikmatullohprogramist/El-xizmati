part of 'create_ad_chooser_cubit.dart';

@freezed
class CreateAdChooserBuildable with _$CreateAdChooserBuildable {
  const factory CreateAdChooserBuildable({
    @Default(false) bool isLogin,
   }) = _CreateAdChooserBuildable;
}

@freezed
class CreateAdChooserListenable with _$CreateAdChooserListenable {
  const factory CreateAdChooserListenable() = _CreateAdChooserListenable;
}
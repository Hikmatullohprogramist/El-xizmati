part of 'confirm_cubit.dart';

@freezed
class ConfirmBuildable with _$ConfirmBuildable {
  const ConfirmBuildable._();

  const factory ConfirmBuildable({
    @Default("") String phone,
    @Default('') String code,
    @Default(false) bool loading,
    @Default(ConfirmType.confirm) ConfirmType confirmType,
    @Default(120) int timerTime,
  }) = _ConfirmBuildable;

  bool get againButtonEnable => timerTime == 0;

  bool get enable => code.length == 4;
}

@freezed
class ConfirmListenable with _$ConfirmListenable {
  const factory ConfirmListenable(ConfirmEffect effect, {String? message}) =
      _ConfirmListenable;
}

enum ConfirmEffect { setPassword }

part of 'confirm_cubit.dart';

@freezed
class ConfirmBuildable with _$ConfirmBuildable {
  const factory ConfirmBuildable({
    @Default("") String phone,
    @Default('') String code,
    @Default(false) bool loading,
    @Default(false) bool enable,
    @Default(ConfirmType.confirm) ConfirmType confirmType,
  }) = _ConfirmBuildable;
}

@freezed
class ConfirmListenable with _$ConfirmListenable {
  const factory ConfirmListenable(ConfirmEffect effect, {String? message}) =
      _ConfirmListenable;
}

enum ConfirmEffect { setPassword }

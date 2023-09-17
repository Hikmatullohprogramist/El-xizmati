part of 'register_cubit.dart';

@freezed
class RegisterBuildable with _$RegisterBuildable {
  const factory RegisterBuildable({
    @Default("") String phone,
    @Default('') String code,
    @Default(false) bool loading,
    @Default(false) bool enable,
}) = _RegisterBuildable;
}

@freezed
class RegisterListenable with _$RegisterListenable {
  const factory RegisterListenable(RegisterEffect effect, {String? message}) =
      _RegisterListenable;
}

enum RegisterEffect { navigationConfirm }

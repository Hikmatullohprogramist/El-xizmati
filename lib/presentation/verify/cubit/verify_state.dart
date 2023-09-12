part of 'verify_cubit.dart';

@freezed
class VerifyBuildable with _$VerifyBuildable {
  const VerifyBuildable._();

  const factory VerifyBuildable({
    @Default('') String phone,
    @Default('') String code,
    @Default(false) bool loading,
  }) = _VerifyBuildable;

  bool get enabled => code.length == 5;
}

@freezed
class VerifyListenable with _$VerifyListenable {
  const factory VerifyListenable(VerifyEffect effect) = _VerifyListenable;
}

enum VerifyEffect { success }
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';

part 'identified_cubit.freezed.dart';

part 'identified_state.dart';

class IdentifiedCubit
    extends BaseCubit<IdentifiedBuildable, IdentifiedListenable> {
  IdentifiedCubit() : super(const IdentifiedBuildable());

  void setBiometricSerial(String serial) {
    build((buildable) => buildable.copyWith(biometricSerial: serial));
    identified();
  }

  void setBiometricNumber(String number) {
    build((buildable) =>
        buildable.copyWith(biometricNumber: number.replaceAll(" ", "")));
    identified();
  }

  void setBrithDate(String brithDate) {
    build((buildable) => buildable.copyWith(brithDate: brithDate));
    identified();
  }

  void setPhoneNumber(String phone) {
    build((buildable) => buildable.copyWith(
        phoneNumber: phone.replaceAll(" ", "").replaceAll("+", "")));
    identified();
  }

  Future<void> identified() async {
    if (buildable.phoneNumber.length >= 12 &&
        buildable.biometricSerial.length >= 2 &&
        buildable.biometricNumber.length >= 7 &&
        buildable.brithDate.length >= 10) {
      try {} catch (e) {}
      return;
    }
  }
}

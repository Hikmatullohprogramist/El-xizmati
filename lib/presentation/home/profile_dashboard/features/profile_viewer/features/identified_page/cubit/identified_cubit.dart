import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';
import 'package:onlinebozor/domain/repository/user_repository.dart';

part 'identified_cubit.freezed.dart';
part 'identified_state.dart';

@Injectable()
class IdentifiedCubit
    extends BaseCubit<IdentifiedBuildable, IdentifiedListenable> {
  IdentifiedCubit(this._userRepository) : super(const IdentifiedBuildable());

  final UserRepository _userRepository;

  void setBiometricSerial(String serial) {
    build((buildable) => buildable.copyWith(biometricSerial: serial));
  }

  void setBiometricNumber(String number) {
    build((buildable) =>
        buildable.copyWith(biometricNumber: number.replaceAll(" ", "")));
  }

  void setBrithDate(String brithDate) {
    build((buildable) => buildable.copyWith(brithDate: brithDate));
  }

  void setPhoneNumber(String phone) {
    build((buildable) => buildable.copyWith(
        phoneNumber: phone.replaceAll(" ", "").replaceAll("+", "")));
  }

  Future<void> identified() async {
    if (buildable.phoneNumber.length >= 12 &&
        buildable.biometricSerial.length >= 2 &&
        buildable.biometricNumber.length >= 7 &&
        buildable.brithDate.length >= 10) {
      try {
        final response = await _userRepository.userIdentified(
            phoneNumber: buildable.phoneNumber,
            biometricSerial: buildable.biometricSerial,
            biometricNumber: buildable.biometricNumber,
            brithDate: buildable.brithDate);
        build((buildable) => buildable.copyWith(
            userName: response.username ?? "",
            biometricSerial: response.passport_serial,
            biometricNumber: response.passport_number,
            fullName: response.full_name,
            email: response.email,
            brithDate: response.birth_date,
            identified: true));
      } catch (e) {}
      return;
    } else {
      log.w(
          "${buildable.phoneNumber}  ${buildable.biometricSerial}  ${buildable.biometricNumber} ${buildable.brithDate}");
      display.error("ma'lumotlarni to'liq kiriting");
    }
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/base/base_cubit.dart';
import 'package:onlinebozor/domain/repository/user_repository.dart';

part 'registration_cubit.freezed.dart';

part 'registration_state.dart';

@Injectable()
class RegistrationCubit
    extends BaseCubit<RegistrationBuildable, RegistrationListenable> {
  RegistrationCubit(this._userRepository)
      : super(const RegistrationBuildable());

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
        mobileNumber: phone,
        phoneNumber: phone.replaceAll(" ", "").replaceAll("+", "")));
  }

  Future<void> validationAndRequest() async {
    if (buildable.phoneNumber.length >= 12 &&
        buildable.biometricSerial.length >= 2 &&
        buildable.biometricNumber.length >= 7 &&
        buildable.brithDate.length >= 10) {
      getUserInformation();
    } else {
      display.error("ma'lumotlarni to'liq kiriting");
    }
  }

  Future<void> getUserInformation() async {
    try {
      final response = await _userRepository.getBiometricInfo(
          phoneNumber: buildable.phoneNumber,
          biometricSerial: buildable.biometricSerial,
          biometricNumber: buildable.biometricNumber,
          brithDate: buildable.brithDate);
      if (response.secret_key != "IN_PROCESS") {
        build((buildable) => buildable.copyWith(
            gender: response.passportInfo?.gender ?? "",
            userName: response.passportInfo?.full_name ?? "",
            biometricSerial: response.passportInfo?.series ?? "",
            biometricNumber: response.passportInfo?.number ?? "",
            fullName: response.passportInfo?.full_name ?? "",
            brithDate: response.passportInfo?.birth_date ?? "",
            isRegistration: true));
      } else {
        await getUserInfo(response.secret_key ?? "", buildable.phoneNumber);
      }
    } catch (e) {
      display.error(e.toString());
    }
  }

  Future<void> getUserInfo(String secretKey, String phoneNumber) async {
    try {
      final response = await _userRepository.getUserInfo(
          phoneNumber: phoneNumber, secretKey: secretKey);
      build((buildable) => buildable.copyWith(
            fullName: response.userInfo.full_name ?? "",
            isRegistration: true,
            districtId: response.userInfo.district_id,
            regionId: response.userInfo.region_id,
          ));
    } catch (e) {
      display.error("Xatolik yuz berdi qayta urinib ko'ring");
    }
  }

  Future<void> sendUserInfo() async {
    try {
      await _userRepository.sendUserInformation(
          email: buildable.email,
          gender: buildable.gender ?? "",
          homeName: "",
          id: 1,
          mahallaId: 1,
          mobilePhone: buildable.mobileNumber ?? "",
          photo: "",
          pinfl: buildable.pinfl ?? -1,
          postName: buildable.postName ?? "",
          phoneNumber: buildable.phoneNumber);
    } catch (e) {
      display.error("Xatolik yuz berdi");
    }
  }
}

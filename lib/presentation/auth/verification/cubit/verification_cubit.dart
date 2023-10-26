import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../domain/repository/auth_repository.dart';

part 'verification_cubit.freezed.dart';
part 'verification_state.dart';

@injectable
class VerificationCubit
    extends BaseCubit<VerificationBuildable, VerificationListenable> {
  VerificationCubit(this._repository) : super(const VerificationBuildable());

  final AuthRepository _repository;

  void setPhone(String phone) {
    build((buildable) => buildable.copyWith(phone: phone, password: ""));
  }

  void setPassword(String password) {
    build((buildable) =>
        buildable.copyWith(password: password, ));
  }

  launchURLApp() async {
    try {
      var url = Uri.parse("https://online-bozor.uz/page/privacy");
      await launchUrl(url);
    } catch (e) {
      display.error(e.toString(), "Urlni parse qilishda xatolik yuz berdi");
    }
  }

  Future<void> verification() async {
    build((buildable) => buildable.copyWith(loading: true));
    try {
      await _repository.verification(
          buildable.phone.clearSpaceInPhone(), buildable.password);
      invoke(VerificationListenable(VerificationEffect.navigationHome));
    } on DioException catch (e, stackTrace) {
      log.w("${e.toString()} ${stackTrace.toString()}");
      if (e.response?.statusCode == 401) {
        display.error("Kiritilgan parrol xato", "Xatolik  yuz berdi");
      } else {
        display.error("Qayta urinib ko'ring", "Xatolik  yuz berdi");
      }
    } finally {
      build((buildable) => buildable.copyWith(loading: false));
    }
  }

  Future<void> forgetPassword() async {
    try {
      await _repository.forgetPassword(buildable.phone.clearSpaceInPhone());
      invoke(VerificationListenable(VerificationEffect.navigationToConfirm));
    } on DioException catch (e, stackTrace) {
      display.error(
          "xatolik yuz berdi qayta urinib ko'ring", "Xatolik  yuz berdi");
    }
  }
}

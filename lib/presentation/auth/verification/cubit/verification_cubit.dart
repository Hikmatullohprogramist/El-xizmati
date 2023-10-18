import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../../domain/repo/auth_repository.dart';

part 'verification_cubit.freezed.dart';

part 'verification_state.dart';

@injectable
class VerificationCubit
    extends BaseCubit<VerificationBuildable, VerificationListenable> {
  VerificationCubit(this._repository) : super(const VerificationBuildable());

  final AuthRepository _repository;

  void setPhone(String phone) {
    build((buildable) => buildable.copyWith(phone: phone));
  }

  void setCode(String code) {
    build((buildable) =>
        buildable.copyWith(code: code, enable: code.length >= 4));
  }

  Future<void> verification() async {
    build((buildable) => buildable.copyWith(loading: true));
    try {
      await _repository.verification(
          buildable.phone.clearSpaceInPhone(), buildable.code);
      invoke(VerificationListenable(VerificationEffect.navigationToHome));
    } on DioException catch (e, stackTrace) {
      if (e.response?.statusCode == 401) {
        display.error("Kiritilgan parrol xato", "Xatolik  yuz berdi");
      } else {}
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

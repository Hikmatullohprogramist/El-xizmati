import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/repositories/favorite_repository.dart';

part 'verification_cubit.freezed.dart';
part 'verification_state.dart';

@injectable
class VerificationCubit
    extends BaseCubit<VerificationBuildable, VerificationListenable> {
  VerificationCubit(this._repository, this._favoriteRepository)
      : super(const VerificationBuildable());

  final AuthRepository _repository;
  final FavoriteRepository _favoriteRepository;

  void setPhone(String phone) {
    updateState((buildable) => buildable.copyWith(phone: phone, password: ""));
  }

  void setPassword(String password) {
    updateState((buildable) => buildable.copyWith(
          password: password,
        ));
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
    updateState((buildable) => buildable.copyWith(loading: true));
    try {
      await _repository.verification(
          currentState.phone.clearSpaceInPhone(), currentState.password);
      sendAllFavoriteAds();
      emitEvent(VerificationListenable(VerificationEffect.navigationHome));
    } on DioException catch (e, stackTrace) {
      log.w("${e.toString()} ${stackTrace.toString()}");
      if (e.response?.statusCode == 401) {
        display.error(
            "Kiritilgan parrol xato (${e.response?.statusCode ?? ""})",
            "Xatolik  yuz berdi");
      } else {
        display.error("Qayta urinib ko'ring (${e.response?.statusCode ?? ""})",
            "Xatolik  yuz berdi");
      }
    } finally {
      updateState((buildable) => buildable.copyWith(loading: false));
    }
  }

  Future<void> forgetPassword() async {
    try {
      await _repository.forgetPassword(currentState.phone.clearSpaceInPhone());
      emitEvent(VerificationListenable(VerificationEffect.navigationToConfirm));
    } on DioException {
      display.error(
          "xatolik yuz berdi qayta urinib ko'ring", "Xatolik  yuz berdi");
    }
  }

  Future<void> sendAllFavoriteAds() async {
    try {
      await _favoriteRepository.pushAllFavoriteAds();
    } catch (error) {
      display.error("Xatolik yuz berdi");
      emitEvent(VerificationListenable(VerificationEffect.navigationHome));
    }
  }
}

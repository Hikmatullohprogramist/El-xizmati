import 'dart:async';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/domain/repositories/favorite_repository.dart';
import 'package:onlinebozor/presentation/auth/confirm/confirm_page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../domain/repositories/auth_repository.dart';

part 'confirm_cubit.freezed.dart';
part 'confirm_state.dart';

@injectable
class ConfirmCubit extends BaseCubit<ConfirmBuildable, ConfirmListenable> {
  ConfirmCubit(this._repository, this._favoriteRepository)
      : super(ConfirmBuildable());

  final AuthRepository _repository;
  final FavoriteRepository _favoriteRepository;
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      build((buildable) =>
          buildable.copyWith(timerTime: buildable.timerTime - 1));
      if (buildable.timerTime == 0) stopTimer();
    });
  }

  void stopTimer() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }
  }

  void setPhone(String phone, ConfirmType confirmType) {
    build((buildable) => buildable.copyWith(
          phone: phone,
          confirmType: confirmType,
          code: "",
        ));
  }

  void setCode(String code) {
    build((buildable) => buildable.copyWith(code: code));
  }

  void confirm() {
    if (ConfirmType.confirm == state.buildable?.confirmType) {
      confirmation();
    } else {
      recoveryConfirmation();
    }
  }

  launchURLApp() async {
    try {
      var url = Uri.parse("https://online-bozor.uz/page/privacy");
      await launchUrl(url);
    } on DioException catch (e) {
      display.error(e.toString(), "Urlni parse qilishda xatolik yuz berdi");
    }
  }

  Future<void> confirmation() async {
    build((buildable) => buildable.copyWith(loading: true));
    try {
      await _repository.confirm(
          buildable.phone.clearSpaceInPhone(), buildable.code);
      _timer?.cancel();
      sendAllFavoriteAds();
      invoke(ConfirmListenable(ConfirmEffect.setPassword));
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      build((buildable) => buildable.copyWith(loading: false));
    }
  }

  Future<void> recoveryConfirmation() async {
    build((buildable) => buildable.copyWith(loading: true));
    try {
      await _repository.recoveryConfirm(
          buildable.phone.clearSpaceInPhone(), buildable.code);
      _timer?.cancel();
      await sendAllFavoriteAds();
      invoke(ConfirmListenable(ConfirmEffect.setPassword));
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      invoke(ConfirmListenable(ConfirmEffect.setPassword));
      display.error(e.toString());
    } finally {
      build((buildable) => buildable.copyWith(loading: false));
    }
  }

  Future<void> sendAllFavoriteAds() async {
    try {
      await _favoriteRepository.pushAllFavoriteAds();
    } catch (error) {
      display.error("Xatolik yuz berdi");
      invoke(ConfirmListenable(ConfirmEffect.setPassword));
    }
  }
}

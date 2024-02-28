import 'dart:async';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/presentation/auth/confirm/page.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/repositories/favorite_repository.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(
    this._repository,
    this._favoriteRepository,
  ) : super(PageState());

  final AuthRepository _repository;
  final FavoriteRepository _favoriteRepository;
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      updateState(
        (state) => state.copyWith(timerTime: state.timerTime - 1),
      );
      if (states.timerTime == 0) stopTimer();
    });
  }

  void stopTimer() {
    if (_timer?.isActive == true) {
      _timer?.cancel();
    }
  }

  void setPhone(String phone, ConfirmType confirmType) {
    updateState(
      (state) => state.copyWith(
        phone: phone,
        confirmType: confirmType,
        code: "",
      ),
    );
  }

  void setCode(String code) {
    updateState((state) => state.copyWith(code: code));
  }

  void confirm() {
    if (ConfirmType.confirm == state.state?.confirmType) {
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
    updateState((state) => state.copyWith(loading: true));
    try {
      await _repository.confirm(
        states.phone.clearSpaceInPhone(),
        states.code,
      );
      _timer?.cancel();
      sendAllFavoriteAds();
      emitEvent(PageEvent(PageEventType.setPassword));
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      display.error(e.toString());
    } finally {
      updateState((state) => state.copyWith(loading: false));
    }
  }

  Future<void> recoveryConfirmation() async {
    updateState((state) => state.copyWith(loading: true));
    try {
      await _repository.recoveryConfirm(
        states.phone.clearSpaceInPhone(),
        states.code,
      );
      _timer?.cancel();
      await sendAllFavoriteAds();
      emitEvent(PageEvent(PageEventType.setPassword));
    } on DioException catch (e, stackTrace) {
      log.e(e.toString(), error: e, stackTrace: stackTrace);
      emitEvent(PageEvent(PageEventType.setPassword));
      display.error(e.toString());
    } finally {
      updateState((state) => state.copyWith(loading: false));
    }
  }

  Future<void> sendAllFavoriteAds() async {
    try {
      await _favoriteRepository.pushAllFavoriteAds();
    } catch (error) {
      display.error("Xatolik yuz berdi");
      emitEvent(PageEvent(PageEventType.setPassword));
    }
  }
}
